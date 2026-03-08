/*
  # Add Study Time Tracking and Goal Management

  1. Updates to user_settings table
    - Add target_exam_date (目標試験日)
    - Add weekly_study_hours_target (週の学習時間目標)
    - Add total_study_minutes (累計学習時間)
    - Add study_start_date (学習開始日)

  2. New study_sessions table
    - Tracks individual study sessions
    - Records date, duration, chapter, task type
    - Enables detailed time analytics
*/

-- Add columns to user_settings table
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'user_settings' AND column_name = 'target_exam_date'
  ) THEN
    ALTER TABLE user_settings ADD COLUMN target_exam_date date;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'user_settings' AND column_name = 'weekly_study_hours_target'
  ) THEN
    ALTER TABLE user_settings ADD COLUMN weekly_study_hours_target decimal(5,2) DEFAULT 20.0;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'user_settings' AND column_name = 'total_study_minutes'
  ) THEN
    ALTER TABLE user_settings ADD COLUMN total_study_minutes int DEFAULT 0;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'user_settings' AND column_name = 'study_start_date'
  ) THEN
    ALTER TABLE user_settings ADD COLUMN study_start_date date DEFAULT CURRENT_DATE;
  END IF;
END $$;

-- Create study_sessions table
CREATE TABLE IF NOT EXISTS study_sessions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  date date NOT NULL DEFAULT CURRENT_DATE,
  duration_minutes int NOT NULL,
  chapter_id uuid REFERENCES chapters(id) ON DELETE CASCADE,
  task_id uuid REFERENCES tasks(id) ON DELETE CASCADE,
  task_type text CHECK (task_type IN ('lecture', 'mc', 'tbs')),
  notes text,
  created_at timestamptz DEFAULT now()
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_study_sessions_date ON study_sessions(date);
CREATE INDEX IF NOT EXISTS idx_study_sessions_chapter_id ON study_sessions(chapter_id);

-- Enable Row Level Security
ALTER TABLE study_sessions ENABLE ROW LEVEL SECURITY;

-- Create policies for study_sessions
CREATE POLICY "Allow public read access on study_sessions"
  ON study_sessions FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public insert on study_sessions"
  ON study_sessions FOR INSERT
  TO public
  WITH CHECK (true);

CREATE POLICY "Allow public update on study_sessions"
  ON study_sessions FOR UPDATE
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow public delete on study_sessions"
  ON study_sessions FOR DELETE
  TO public
  USING (true);