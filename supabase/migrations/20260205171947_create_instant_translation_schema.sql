/*
  # Create Instant Translation Practice Schema (Section 4)

  ## Summary
  This migration creates a fourth independent component for instant Japanese-English
  translation practice. This is separate from MC questions, MC Tips, and Practical English sections.

  ## Purpose
  - Quick instant translation practice (Japanese → English)
  - Focus: Accounting terminology and short phrases
  - Format: Short sentence flashcards
  - Independent from Section 3's professional judgment explanations

  ## New Tables
  1. `instant_translation_flashcards`
     - `id` (uuid, primary key)
     - `chapter_id` (uuid, foreign key to chapters)
     - `topic` (text) - Accounting topic (e.g., "impairment", "provisions")
     - `japanese_sentence` (text) - Japanese sentence to translate
     - `english_translation` (text) - Target English translation
     - `difficulty` (text) - 'basic', 'intermediate', 'advanced'
     - `keywords` (text) - Key vocabulary to focus on
     - `order_index` (integer) - Display order within chapter
     - `created_at` (timestamptz)
  
  2. `instant_translation_progress`
     - `id` (uuid, primary key)
     - `user_id` (uuid, no foreign key - single user app)
     - `flashcard_id` (uuid, foreign key to instant_translation_flashcards)
     - `status` (text) - 'not_started', 'practicing', 'mastered'
     - `last_practiced_at` (timestamptz)
     - `practice_count` (integer) - Number of times practiced
     - `created_at` (timestamptz)

  ## Security
  - Enable RLS on both tables
  - Allow anonymous access (single-user app)
*/

-- Create instant_translation_flashcards table
CREATE TABLE IF NOT EXISTS instant_translation_flashcards (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  chapter_id uuid REFERENCES chapters(id) ON DELETE CASCADE NOT NULL,
  topic text NOT NULL,
  japanese_sentence text NOT NULL,
  english_translation text NOT NULL,
  difficulty text NOT NULL DEFAULT 'intermediate' CHECK (difficulty IN ('basic', 'intermediate', 'advanced')),
  keywords text NOT NULL,
  order_index integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create instant_translation_progress table
CREATE TABLE IF NOT EXISTS instant_translation_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  flashcard_id uuid REFERENCES instant_translation_flashcards(id) ON DELETE CASCADE NOT NULL,
  status text NOT NULL DEFAULT 'not_started' CHECK (status IN ('not_started', 'practicing', 'mastered')),
  last_practiced_at timestamptz,
  practice_count integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, flashcard_id)
);

-- Enable RLS
ALTER TABLE instant_translation_flashcards ENABLE ROW LEVEL SECURITY;
ALTER TABLE instant_translation_progress ENABLE ROW LEVEL SECURITY;

-- Policies for instant_translation_flashcards (allow both authenticated and anon)
CREATE POLICY "Anyone can view instant translation flashcards"
  ON instant_translation_flashcards
  FOR SELECT
  TO authenticated, anon
  USING (true);

-- Policies for instant_translation_progress (allow both authenticated and anon)
CREATE POLICY "Anyone can view instant translation progress"
  ON instant_translation_progress
  FOR SELECT
  TO authenticated, anon
  USING (true);

CREATE POLICY "Anyone can insert instant translation progress"
  ON instant_translation_progress
  FOR INSERT
  TO authenticated, anon
  WITH CHECK (true);

CREATE POLICY "Anyone can update instant translation progress"
  ON instant_translation_progress
  FOR UPDATE
  TO authenticated, anon
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Anyone can delete instant translation progress"
  ON instant_translation_progress
  FOR DELETE
  TO authenticated, anon
  USING (true);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_instant_translation_flashcards_chapter_id 
  ON instant_translation_flashcards(chapter_id);
CREATE INDEX IF NOT EXISTS idx_instant_translation_progress_user_id 
  ON instant_translation_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_instant_translation_progress_flashcard_id 
  ON instant_translation_progress(flashcard_id);
