import React, { useState, useEffect } from "react";
import { useLocation, useNavigate, Link } from "react-router-dom";
import axios from "axios";

const ExamPage = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const { username, examType, subject, useTimer, duration } = location.state || {};

  const [questions, setQuestions] = useState([]);
  const [attemptId, setAttemptId] = useState(null);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [answers, setAnswers] = useState({});
  const [timeLeft, setTimeLeft] = useState(duration * 60 || 0);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchQuestions = async () => {
      try {
        const response = await axios.post("http://localhost:5000/api/start-session", {
          username,
          subject,
          examType,
        });
        setQuestions(response.data.questions);
        setAttemptId(response.data.attemptId);
        setLoading(false);
      } catch (error) {
        console.error("Error fetching questions:", error);
        setLoading(false);
      }
    };
    fetchQuestions();
  }, [username, subject, examType]);

  useEffect(() => {
    if (!useTimer || !questions.length) return;
    if (timeLeft <= 0) {
      finishExam();
      return;
    }
    const timer = setInterval(() => setTimeLeft((prev) => prev - 1), 1000);
    return () => clearInterval(timer);
  }, [timeLeft, useTimer, questions]);

  const handleSelectAnswer = (qId, value) => {
    setAnswers((prev) => ({ ...prev, [qId]: value }));
  };

  const handleNext = () => {
    if (currentIndex < questions.length - 1) {
      setCurrentIndex((prev) => prev + 1);
    } else {
      finishExam();
    }
  };

  const handlePrevious = () => {
    if (currentIndex > 0) {
      setCurrentIndex((prev) => prev - 1);
    }
  };

  const finishExam = async () => {
    const answeredCount = Object.keys(answers).length;
    if (answeredCount < questions.length) {
      if (!window.confirm(`You have ${questions.length - answeredCount} unanswered questions. Submit anyway?`)) {
        return;
      }
    }
    try {
      const response = await axios.post("http://localhost:5000/api/submit", {
        answers,
        questions,
        formData: { username, examType, subject, duration },
        timeUsed: useTimer ? duration * 60 - timeLeft : null,
        attemptId,
      });
      navigate("/result", {
        state: {
          formData: { username, examType, subject, useTimer, duration },
          result: response.data,
        },
      });
    } catch (error) {
      console.error("Error submitting answers:", error);
      alert("Failed to submit exam. Please try again.");
    }
  };

  if (loading) {
    return (
      <div className="app-container">
        <header className="header-global">
          <h1 className="logo-global bounce">FEMGRIND</h1>
        </header>
        <main className="flex flex-col items-center justify-center">
          <p className="text-primary pulse" style={{ fontSize: '1rem' }}>Loading questions...</p>
        </main>
        <footer className="footer-global">
          <p>Support: <a href="mailto:Femgrindng@gmail.com">Femgrindng@gmail.com</a></p>
          <p><Link to="/terms" style={{ color: 'inherit', textDecoration: 'underline' }}>Terms of Use</Link></p>
          <p>FEMGRIND © 2025. All rights reserved</p>
        </footer>
      </div>
    );
  }

  if (!questions.length) {
    return (
      <div className="app-container">
        <header className="header-global">
          <h1 className="logo-global bounce">FEMGRIND</h1>
        </header>
        <main className="flex flex-col items-center justify-center">
          <p style={{ marginBottom: '1rem' }}>No questions available for {subject}.</p>
          <button onClick={() => navigate("/")} className="btn-primary">
            Back to Home
          </button>
        </main>
        <footer className="footer-global">
          <p>Support: <a href="mailto:Femgrindng@gmail.com">Femgrindng@gmail.com</a></p>
          <p><Link to="/terms" style={{ color: 'inherit', textDecoration: 'underline' }}>Terms of Use</Link></p>
          <p>FEMGRIND © 2025. All rights reserved</p>
        </footer>
      </div>
    );
  }

  const currentQuestion = questions[currentIndex];

  return (
    <div className="app-container">
      <header className="header-global">
        <h1 className="logo-global bounce">FEMGRIND</h1>
        <p style={{ fontSize: '0.875rem', marginTop: '0.25rem' }}>
          Welcome, {username || "User"}!
        </p>
        <p style={{ fontSize: '0.875rem', marginTop: '0.25rem' }}>
          Exam: {examType} | Subject: {subject}
        </p>
        {useTimer && (
          <p style={{ 
            fontSize: '0.875rem',
            fontWeight: 'bold',
            background: 'var(--primary-hover)',
            display: 'inline-block',
            padding: '0.25rem 0.5rem',
            borderRadius: '0.25rem',
            marginTop: '0.25rem'
          }}>
            Time Left: {Math.floor(timeLeft / 60)}:{String(timeLeft % 60).padStart(2, "0")}
          </p>
        )}
      </header>
      
      <main className="flex flex-col items-center" style={{ padding: '2rem 1.5rem' }}>
        <div className="card-3d w-full max-w-xl fadeIn" style={{
          padding: '1.5rem',
          margin: '1rem 0'
        }}>
          <h2 style={{
            fontSize: '1.25rem',
            marginBottom: '1rem',
            color: 'var(--primary)'
          }}>
            Q{currentIndex + 1}. {currentQuestion.question}
          </h2>
          
          <ul style={{ listStyle: 'none', padding: 0 }}>
            {currentQuestion.options.map((opt, idx) => (
              <li key={idx} style={{ margin: '0.5rem 0' }}>
                <label style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem',
                  fontSize: '1rem',
                  color: 'var(--foreground)',
                  cursor: 'pointer'
                }}>
                  <input
                    type="radio"
                    name={`q${currentQuestion.id}`}
                    value={idx}
                    checked={answers[currentQuestion.id] === idx}
                    onChange={() => handleSelectAnswer(currentQuestion.id, idx)}
                  />
                  <span style={{
                    transition: 'color 0.3s ease',
                    color: answers[currentQuestion.id] === idx ? 'var(--primary)' : 'inherit',
                    fontWeight: answers[currentQuestion.id] === idx ? '500' : 'normal'
                  }}>
                    {opt}
                  </span>
                </label>
              </li>
            ))}
          </ul>
          
          <div className="flex gap-4" style={{ 
            justifyContent: 'space-between',
            marginTop: '1.5rem'
          }}>
            <button
              onClick={handlePrevious}
              disabled={currentIndex === 0}
              className="btn-primary"
              style={{ flex: 1 }}
            >
              Previous
            </button>
            <button
              onClick={handleNext}
              className="btn-primary"
              style={{ flex: 1 }}
            >
              {currentIndex === questions.length - 1 ? "Finish Exam" : "Next"}
            </button>
          </div>
        </div>
      </main>
      
      <footer className="footer-global">
         <p> <Link to="/terms" style={{ color: "inherit", textDecoration: "underline" }}> Terms of Use</Link>
                      &nbsp; Support: <a href="mailto:Femgrindng@gmail.com">Femgrindng@gmail.com</a>   
                            </p>
                     <p> &copy; FEMGRIND {new Date().getFullYear()}.     POWERED BY SUNMOLA TECHNOLOGIES.</p>
                 </footer>
    </div>
  );
};

export default ExamPage;