const { Pool } = require('pg');
require('dotenv').config({ path: '../.env' });

const pool = new Pool({
  user: process.env.DB_USER,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
});

const subjects = ['maths_questions.json','government_questions.json','crs_questions.json',  'commerce_questions.json',  'economics_questions.json',  'chemistry_questions.json', 'biology_questions.json',  'physics_questions.json',  'civic_questions.json',  'english_questions.json'];

async function importQuestions() {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    for (const subjectFile of subjects) {
      const questions = require(`./${subjectFile}`);
      for (const q of questions) {
        await client.query(
          'INSERT INTO femgrind_questions (subject, grade_level, exam_type, question, options, correct_answer, justification) VALUES ($1, $2, $3, $4, $5, $6, $7) ON CONFLICT (subject, question) DO NOTHING',
          [q.subject, q.grade_level, q.exam_type, q.question, JSON.stringify(q.options), q.correct_answer, q.justification]
        );
      }
      console.log(`Questions from ${subjectFile} imported successfully`);
    }
    await client.query('COMMIT');
  } catch (err) {
    await client.query('ROLLBACK');
    console.error('Error importing questions:', err.message, err.stack);
  } finally {
    client.release();
  }
  await pool.end();
}

importQuestions();