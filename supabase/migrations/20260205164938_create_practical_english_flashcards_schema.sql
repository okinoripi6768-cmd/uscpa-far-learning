/*
  # Create Practical Accounting English Flashcards Schema

  ## Summary
  This migration creates a third independent component for practical accounting English
  practice. This is separate from MC question progress tracking and MC Tips flashcards.

  ## Purpose
  - Instant English composition practice
  - Format: Japanese → English flashcard
  - Focus: explaining accounting judgments safely in English
  - NOT a test of accounting correctness
  - Suitable for: audit discussions, M&A, cross-border reporting

  ## New Tables
  1. `practical_english_flashcards`
     - `id` (uuid, primary key)
     - `chapter_id` (uuid, foreign key to chapters)
     - `topic` (text) - Accounting topic (e.g., "impairment", "provisions")
     - `japanese_prompt` (text) - Japanese sentence on the front
     - `english_answer` (text) - Model English answer (2-4 sentences)
     - `key_phrases` (text) - Key reasoning phrases used
     - `order_index` (integer) - Display order within chapter
     - `created_at` (timestamptz)
  
  2. `practical_english_progress`
     - `id` (uuid, primary key)
     - `user_id` (uuid, no foreign key - single user app)
     - `flashcard_id` (uuid, foreign key to practical_english_flashcards)
     - `status` (text) - 'not_started', 'practicing', 'confident'
     - `last_practiced_at` (timestamptz)
     - `practice_count` (integer) - Number of times practiced
     - `created_at` (timestamptz)

  ## Security
  - Enable RLS on both tables
  - Allow anonymous access (single-user app)
*/

-- Create practical_english_flashcards table
CREATE TABLE IF NOT EXISTS practical_english_flashcards (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  chapter_id uuid REFERENCES chapters(id) ON DELETE CASCADE NOT NULL,
  topic text NOT NULL,
  japanese_prompt text NOT NULL,
  english_answer text NOT NULL,
  key_phrases text NOT NULL,
  order_index integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create practical_english_progress table
CREATE TABLE IF NOT EXISTS practical_english_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  flashcard_id uuid REFERENCES practical_english_flashcards(id) ON DELETE CASCADE NOT NULL,
  status text NOT NULL DEFAULT 'not_started' CHECK (status IN ('not_started', 'practicing', 'confident')),
  last_practiced_at timestamptz,
  practice_count integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, flashcard_id)
);

-- Enable RLS
ALTER TABLE practical_english_flashcards ENABLE ROW LEVEL SECURITY;
ALTER TABLE practical_english_progress ENABLE ROW LEVEL SECURITY;

-- Policies for practical_english_flashcards (allow both authenticated and anon)
CREATE POLICY "Anyone can view practical English flashcards"
  ON practical_english_flashcards
  FOR SELECT
  TO authenticated, anon
  USING (true);

-- Policies for practical_english_progress (allow both authenticated and anon)
CREATE POLICY "Anyone can view practical English progress"
  ON practical_english_progress
  FOR SELECT
  TO authenticated, anon
  USING (true);

CREATE POLICY "Anyone can insert practical English progress"
  ON practical_english_progress
  FOR INSERT
  TO authenticated, anon
  WITH CHECK (true);

CREATE POLICY "Anyone can update practical English progress"
  ON practical_english_progress
  FOR UPDATE
  TO authenticated, anon
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Anyone can delete practical English progress"
  ON practical_english_progress
  FOR DELETE
  TO authenticated, anon
  USING (true);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_practical_english_flashcards_chapter_id 
  ON practical_english_flashcards(chapter_id);
CREATE INDEX IF NOT EXISTS idx_practical_english_progress_user_id 
  ON practical_english_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_practical_english_progress_flashcard_id 
  ON practical_english_progress(flashcard_id);
