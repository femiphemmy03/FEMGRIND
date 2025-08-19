import React from "react";
import { useLocation, useNavigate, Link } from "react-router-dom";
import axios from "axios";

const ResultPage = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const { result, formData } = location.state || {};
  const { answered, score, correctQuestions, missedQuestions, timeUsed } = result || {};

  const formatTime = (seconds) => {
    if (!seconds && seconds !== 0) return "No timer";
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}m ${secs}s`;
  };

  const handleDownload = async () => {
    try {
      const response = await axios.post(
        "https://femgrind.onrender.com/api/download/pdf",
        { result, formData },
        { responseType: 'blob' }
      );
      const url = window.URL.createObjectURL(new Blob([response.data]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', `${formData.username}_result.pdf`);
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    } catch (error) {
      console.error("Error downloading PDF:", error);
      alert("Failed to download PDF. Please try again.");
    }
  };

  const handleShare = async () => {
  const shareText = ` I just scored ${score.toFixed(1)}% (${result.totalCorrect || correctQuestions.length}/20) in ${formData.examType} ${formData.subject} on FEMGRIND! Come and try out FEMGRIND to boost your scores!`;
  const shareUrl = "https://femgrindng.onrender.com";

  if (navigator.share) {
    try {
      await navigator.share({
        title: "My FEMGRIND Score",
        text: shareText,
        url: shareUrl,
      });
    } catch (error) {
      console.error("Share failed:", error);
      alert(`${shareText} ${shareUrl}`);
    }
  } else {
    alert(`${shareText} ${shareUrl}`);
  }
};


  const handleHome = () => navigate("/");

  if (!result || !formData) {
    return (
      <div className="app-container">
        <header className="header-global">
          <h1 className="logo-global bounce">FEMGRIND</h1>
        </header>
        <main className="flex flex-col items-center justify-center">
          <p className="text-primary pulse" style={{ fontSize: '1rem' }}>Loading results...</p>
        </main>
        <footer className="footer-global">
          <p>Support: <a href="mailto:Femgrindng@gmail.com">Femgrindng@gmail.com</a></p>
          <p><Link to="/terms" style={{ color: 'inherit', textDecoration: 'underline' }}>Terms of Use</Link></p>
          <p>FEMGRIND © 2025. All rights reserved</p>
        </footer>
      </div>
    );
  }

  return (
    <div className="app-container">
      <header className="header-global">
        <h1 className="logo-global bounce">FEMGRIND</h1>
        <p style={{ fontSize: '0.875rem', marginTop: '0.25rem' }}>
          Welcome, {formData.username || "User"}!
        </p>
      </header>
      
      <main className="w-full max-w-xl" style={{ 
        padding: '2rem 1rem',
        margin: '0 auto'
      }}>
        <h2 className="text-primary fadeIn" style={{
          fontSize: '1.5rem',
          marginBottom: '1rem'
        }}>
          Test Results
        </h2>
        
        <div style={{ marginBottom: '1.5rem' }}>
          <p style={{ fontSize: '1rem', margin: '0.5rem 0' }}>
            <strong>Username:</strong> {formData.username}
          </p>
          <p style={{ fontSize: '1rem', margin: '0.5rem 0' }}>
            <strong>Exam:</strong> {formData.examType} | <strong>Subject:</strong> {formData.subject}
          </p>
          <p style={{ fontSize: '1rem', margin: '0.5rem 0' }}>
            <strong>Score:</strong> {score.toFixed(1)}% ({correctQuestions.length}/20)
          </p>
          <p style={{ fontSize: '1rem', margin: '0.5rem 0' }}>
            <strong>Time Used:</strong> {formatTime(timeUsed)}
          </p>
        </div>

        <h3 className="text-primary" style={{
          fontSize: '1.25rem',
          margin: '1.5rem 0 0.5rem'
        }}>
          Correct Answers:
        </h3>
        {correctQuestions.map((q, i) => (
          <div key={i} className="card-3d slideIn" style={{
            marginBottom: '1rem',
            padding: '1rem',
            borderLeft: '6px solid #22C55E'
          }}>
            <p style={{ marginBottom: '0.5rem' }}>
              <strong>{i + 1}.</strong> {q.question}
            </p>
            <p style={{ color: 'var(--muted-foreground)', fontSize: '0.875rem' }}>
              <strong>Your Answer:</strong> {q.userAnswer}
            </p>
            <p style={{ color: 'var(--muted-foreground)', fontSize: '0.875rem' }}>
              <strong>Correct Answer:</strong> {q.correctAnswer}
            </p>
          </div>
        ))}

        <h3 className="text-primary" style={{
          fontSize: '1.25rem',
          margin: '1.5rem 0 0.5rem'
        }}>
          Missed Answers:
        </h3>
        {missedQuestions.map((q, i) => (
          <div key={i} className="card-3d slideIn" style={{
            marginBottom: '1rem',
            padding: '1rem',
            borderLeft: '6px solid #EF4444'
          }}>
            <p style={{ marginBottom: '0.5rem' }}>
              <strong>{i + 1}.</strong> {q.question}
            </p>
            <p style={{ color: 'var(--muted-foreground)', fontSize: '0.875rem' }}>
              <strong>Your Answer:</strong> {q.userAnswer}
            </p>
            <p style={{ color: 'var(--muted-foreground)', fontSize: '0.875rem' }}>
              <strong>Correct Answer:</strong> {q.correctAnswer}
            </p>
            <p style={{ 
              fontStyle: 'italic',
              color: 'var(--muted-foreground)',
              fontSize: '0.875rem',
              marginTop: '0.5rem'
            }}>
              <strong>Justification:</strong> {q.justification}
            </p>
          </div>
        ))}

        <div className="flex gap-4" style={{ 
          flexWrap: 'wrap',
          justifyContent: 'center',
          margin: '2rem 0'
        }}>
          <button onClick={handleDownload} className="btn-primary">
            Download PDF
          </button>
          <button onClick={handleShare} className="btn-primary">
            Share
          </button>
          <button onClick={handleHome} className="btn-primary">
            Home
          </button>
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

export default ResultPage;