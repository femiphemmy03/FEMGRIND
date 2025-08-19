const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

// Supabase credentials
const supabaseUrl = 'https://ftezwfhfpsgqiuqneupo.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ0ZXp3ZmhmcHNncWl1cW5ldXBvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU1MjcxNTEsImV4cCI6MjA3MTEwMzE1MX0.Vlk4j38GUCtMHxBhRGMSe9CAkif4XrX34hZeaSCWCPg';
const supabase = createClient(supabaseUrl, supabaseKey);

// List of subject files
const subjects = [
  'maths_questions.json',
  'government_questions.json',
  'crs_questions.json',
  'commerce_questions.json',
  'economics_questions.json',
  'chemistry_questions.json',
  'biology_questions.json',
  'physics_questions.json',
  'civic_questions.json',
  'english_questions.json'
];

async function importQuestions() {
  try {
    for (const subjectFile of subjects) {
      const filePath = path.join('./', subjectFile);
      const rawData = fs.readFileSync(filePath);
      const questions = JSON.parse(rawData);

      let insertedCount = 0;

      for (const q of questions) {
        const { error } = await supabase
          .from('femgrind_questions')
          .insert([{
            subject: q.subject,
            grade_level: q.grade_level,
            exam_type: q.exam_type,
            question: q.question,
            options: q.options,
            correct_answer: q.correct_answer,
            justification: q.justification
          }]);

        if (error) {
          console.error(`❌ Error inserting question:`, error.message);
        } else {
          insertedCount++;
        }
      }

      console.log(`✅ ${insertedCount} questions imported from ${subjectFile}`);
    }
  } catch (err) {
    console.error('🚨 Import failed:', err.message);
  }
}

importQuestions();