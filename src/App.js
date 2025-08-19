import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import HomePage from './pages/HomePage.js';
import ExamPage from './pages/ExamPage.js';
import ResultPage from './pages/ResultPage.js';
import TermsPage from "./pages/TermsPage.js";
import './App.css'; 
import './index.css';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/exam" element={<ExamPage />} />
        <Route path="/result" element={<ResultPage />} />
          <Route path="/terms" element={<TermsPage />} />
        
      </Routes>
    </Router>
  );
}

export default App;