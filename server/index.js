const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const PDFDocument = require('pdfkit');
const path = require('path');
const helmet = require('helmet');
require('dotenv').config();

const app = express();
app.use(helmet());
app.use(cors());
app.use(express.json());
app.use('/uploads', express.static(path.join(__dirname, 'Uploads')));

// Supabase connection
const pool = new Pool({
  user: process.env.DB_USER,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  ssl: {
    rejectUnauthorized: false,
  },
  max: 20, // better for 100 testers
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 5000,
});

//Catch unexpected shutdowns
pool.on('error', (err) => {
  console.error('🛑 Database connection error:', err.message);
});

// 🔄 Keep-alive ping every 30 seconds
setInterval(() => {
  pool.query('SELECT 1').catch((err) => {
    console.warn('⚠️ Keep-alive failed:', err.message);
  });
}, 30000);

// Test DB connection
pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('❌ Supabase connection failed:', err);
  } else {
    console.log('✅ Connected to Supabase:', res.rows[0].now);
  }
});

// Health check route
app.get('/api/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date() });
});

// Start session route
app.post('/api/start-session', async (req, res) => {
  const { username, subject, examType } = req.body;
  if (!username || !subject) {
    return res.status(400).json({ error: 'Username and subject are required' });
  }

  try {
    const recentAttempts = await pool.query(
      'SELECT answers FROM attempts WHERE username = $1 AND subject = $2 AND created_at > NOW() - INTERVAL \'24 hours\'',
      [username, subject]
    );

    const usedQuestionIds = recentAttempts.rows.reduce((acc, row) => {
      const answers = row.answers || {};
      return [...acc, ...Object.keys(answers).map(Number)];
    }, []);

    const query = usedQuestionIds.length
      ? 'SELECT id, subject, question, options, correct_answer, justification FROM femgrind_questions WHERE subject = $1 AND id != ALL($2) ORDER BY RANDOM() LIMIT 20'
      : 'SELECT id, subject, question, options, correct_answer, justification FROM femgrind_questions WHERE subject = $1 ORDER BY RANDOM() LIMIT 20';

    const params = usedQuestionIds.length ? [subject, usedQuestionIds] : [subject];
    const result = await pool.query(query, params);

    if (result.rows.length < 20) {
      return res.status(400).json({ error: `Not enough questions available for ${subject}` });
    }

    const attempt = await pool.query(
      'INSERT INTO attempts (username, subject, exam_type, answers, created_at) VALUES ($1, $2, $3, $4, CURRENT_TIMESTAMP) RETURNING id',
      [username, subject, examType || null, {}]
    );

    res.json({ questions: result.rows, attemptId: attempt.rows[0].id });
  } catch (err) {
    console.error('🔥 Start session error:', err);
    res.status(500).json({ error: 'Failed to start session' });
  }
});

// Submit answers route
app.post('/api/submit', async (req, res) => {
  const { answers, questions, formData, timeUsed, attemptId } = req.body;
  const { username, subject, examType } = formData;

  try {
    let answered = 0;
    let correct = 0;
    const correctQuestions = [];
    const missedQuestions = [];

    for (const question of questions) {
      const qId = question.id;
      if (answers.hasOwnProperty(qId)) {
        answered++;
        const userAnswer = parseInt(answers[qId]);
        if (userAnswer === question.correct_answer) {
          correct++;
          correctQuestions.push({
            question: question.question,
            userAnswer: question.options[userAnswer],
            correctAnswer: question.options[question.correct_answer],
          });
        } else {
          missedQuestions.push({
            question: question.question,
            userAnswer: question.options[userAnswer] || 'Not answered',
            correctAnswer: question.options[question.correct_answer],
            justification: question.justification || 'No justification provided',
          });
        }
      } else {
        missedQuestions.push({
          question: question.question,
          userAnswer: 'Not answered',
          correctAnswer: question.options[question.correct_answer],
          justification: question.justification || 'No justification provided',
        });
      }
    }

    // ✅ Calculate score before using it
    const score = (correct / questions.length) * 100;

    // ✅ Save answers and score to database
    await pool.query(
      'UPDATE attempts SET answers = $1, score = $2 WHERE id = $3',
      [answers, score, attemptId]
    );

    // ✅ Send response
    res.json({ answered, score, correctQuestions, missedQuestions, timeUsed });
  } catch (err) {
    console.error('🔥 Submit error:', err);
    res.status(500).json({ error: 'Failed to submit answers' });
  }
});

   

// PDF download route
app.post('/api/download/pdf', (req, res) => {
  try {
    const { result, formData } = req.body;
    const { username, email, examType, subject, duration } = formData;
    const { answered, score, correctQuestions, missedQuestions, timeUsed } = result;

    const doc = new PDFDocument({ font: 'Helvetica' });
    let buffers = [];
    doc.on('data', buffers.push.bind(buffers));
    doc.on('end', () => {
      const pdfData = Buffer.concat(buffers);
      res.setHeader('Content-Type', 'application/pdf');
      res.setHeader('Content-Disposition', `attachment; filename=${username}_result.pdf`);
      res.send(pdfData);
    });

    doc.fillColor('#7c3aed').fontSize(16).text('FEMGRIND Test Result', { align: 'center' });
    doc.moveDown();
    doc.fillColor('#000').fontSize(12);
    doc.text(`Username: ${username}`);
    doc.text(`Email: ${email}`);
    doc.text(`Exam Type: ${examType || 'N/A'}`);
    doc.text(`Subject: ${subject}`);
    doc.text(`Time Used: ${timeUsed ? formatTime(timeUsed) : duration ? `${duration} minutes` : 'No timer'}`);
    doc.text(`Questions Answered: ${answered}`);
    doc.text(`Score: ${score.toFixed(1)}%`);
    doc.moveDown();

    doc.fillColor('#7c3aed').fontSize(12).text('Correct Questions:', { underline: true });
    doc.fillColor('#000');
    correctQuestions.forEach((q, i) => {
      doc.text(`${i + 1}. ${q.question}`);
      doc.text(`Your Answer: ${q.userAnswer}`);
      doc.text(`Correct Answer: ${q.correctAnswer}`);
      doc.moveDown(0.5);
    });

    doc.fillColor('#7c3aed').text('Missed Questions:', { underline: true });
    doc.fillColor('#000');
    missedQuestions.forEach((q, i) => {
      doc.text(`${i + 1}. ${q.question}`);
      doc.text(`Your Answer: ${q.userAnswer}`);
      doc.text(`Correct Answer: ${q.correctAnswer}`);
      doc.text(`Justification: ${q.justification}`);
      doc.moveDown(0.5);
    });

    doc.end();
  } catch (err) {
    console.error('🔥 PDF generation error:', err);
    res.status(500).json({ error: 'Failed to generate PDF' });
  }
});

function formatTime(seconds) {
  const mins = Math.floor(seconds / 60);
  const secs = seconds % 60;
  return `${mins}m ${secs}s`;
}

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));