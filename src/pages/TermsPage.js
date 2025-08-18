import React from "react";
import { Link } from "react-router-dom";

const TermsPage = () => {
  return (
    <div className="app-container">
      <header className="header-global">
        <h1 className="logo-global bounce">FEMGRIND</h1>
      </header>
      
      <main className="w-full max-w-xl" style={{ 
        padding: '2rem 1rem',
        margin: '0 auto'
      }}>
        <h2 className="text-primary fadeIn" style={{
          fontSize: '1.5rem',
          marginBottom: '1rem'
        }}>
          Terms of Use
        </h2>
        
        <section style={{ marginBottom: '2rem' }}>
          <h3 className="text-primary" style={{
            fontSize: '1.25rem',
            margin: '1.5rem 0 0.5rem'
          }}>
            How to Use FEMGRIND
          </h3>
          <p style={{ 
            fontSize: '1rem',
            marginBottom: '1rem',
            lineHeight: '1.6'
          }}>
            Welcome to FEMGRIND — your ultimate exam prep companion! FEMGRIND is a smart, student-focused platform designed to help you excel in major exams like WAEC, JAMB, and POST-UTME. What sets us apart? <b>AI-powered learning</b>.
</p>
<p style={{
fontSize: '1rem',
marginBottom: '1rem',
lineHeight: '1.6'
}}>
<b>Real-Time Question Generation</b>: Our advanced AI creates practice questions instantly, tailored to your subject and level. No recycled content — just fresh, relevant questions every time you study.
</p>
<p style={{
fontSize: '1rem',
marginBottom: '1rem',
lineHeight: '1.6'
}}>
To use the site:
</p>
          <ul style={{ 
            listStyleType: 'disc',
            marginLeft: '1.5rem',
            marginBottom: '1rem'
          }}>
            <li style={{ marginBottom: '0.5rem' }}>
              Navigate to the homepage and fill out the form with your username, email, exam type, and subject.
            </li>
            <li style={{ marginBottom: '0.5rem' }}>
              Choose whether to enable a timer and set the duration.
            </li>
            <li style={{ marginBottom: '0.5rem' }}>
              Take the exam, answer questions, and submit to view your results.
            </li>
            <li style={{ marginBottom: '0.5rem' }}>
              Download your results as a PDF or share them via social media.
            </li>
          </ul>
        </section>
        
        <section style={{ marginBottom: '2rem' }}>
          <h3 className="text-primary" style={{
            fontSize: '1.25rem',
            margin: '1.5rem 0 0.5rem'
          }}>
            Privacy Policy
          </h3>
          <p style={{ 
            fontSize: '1rem',
            marginBottom: '1rem',
            lineHeight: '1.6'
          }}>
            At FEMGRIND, we value your privacy. We collect your username and email to personalize your experience and store your exam attempts. Your data is not shared with third parties except as required by law. For support, contact{' '}
            <a 
              href="mailto:Femgrindng@gmail.com"
              style={{
                color: 'var(--primary)',
                textDecoration: 'underline'
              }}
            >
              Femgrindng@gmail.com
            </a>.
          </p>
        </section>
        
        <button className="btn-primary" style={{
          display: 'inline-block',
          marginTop: '1rem'
        }}>
          <Link 
            to="/"
            style={{
              color: 'inherit',
              textDecoration: 'none'
            }}
          >
            Back to Home
          </Link>
        </button>
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

export default TermsPage;