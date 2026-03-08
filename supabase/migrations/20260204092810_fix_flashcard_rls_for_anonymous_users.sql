/*
  # Fix Flashcard RLS Policies for Anonymous Users

  ## Summary
  This migration updates the Row Level Security (RLS) policies for flashcard tables
  to allow anonymous (non-authenticated) users to access them. This is necessary
  because the application is a single-user app without authentication.

  ## Changes
  1. Drop existing authenticated-only policies
  2. Create new policies that allow both authenticated and anonymous users

  ## Tables Modified
  - `flashcards` - Allow anonymous users to read flashcards
  - `flashcard_progress` - Allow anonymous users full access to flashcard progress

  ## Security Notes
  Since this is a single-user application without authentication, allowing anonymous
  access is acceptable. The fixed user ID (00000000-0000-0000-0000-000000000001)
  is used in the application code to track progress.
*/

-- Drop existing policies for flashcards
DROP POLICY IF EXISTS "Anyone can view flashcards" ON flashcards;

-- Drop existing policies for flashcard_progress
DROP POLICY IF EXISTS "Users can view own flashcard progress" ON flashcard_progress;
DROP POLICY IF EXISTS "Users can insert own flashcard progress" ON flashcard_progress;
DROP POLICY IF EXISTS "Users can update own flashcard progress" ON flashcard_progress;
DROP POLICY IF EXISTS "Users can delete own flashcard progress" ON flashcard_progress;

-- Create new policies for flashcards (allow both authenticated and anon)
CREATE POLICY "Anyone can view flashcards"
  ON flashcards
  FOR SELECT
  TO authenticated, anon
  USING (true);

-- Create new policies for flashcard_progress (allow both authenticated and anon)
CREATE POLICY "Anyone can view flashcard progress"
  ON flashcard_progress
  FOR SELECT
  TO authenticated, anon
  USING (true);

CREATE POLICY "Anyone can insert flashcard progress"
  ON flashcard_progress
  FOR INSERT
  TO authenticated, anon
  WITH CHECK (true);

CREATE POLICY "Anyone can update flashcard progress"
  ON flashcard_progress
  FOR UPDATE
  TO authenticated, anon
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Anyone can delete flashcard progress"
  ON flashcard_progress
  FOR DELETE
  TO authenticated, anon
  USING (true);
