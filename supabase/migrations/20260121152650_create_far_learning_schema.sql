/*
  # USCPA FAR Learning Management System - Database Schema

  ## Overview
  This migration creates the complete database schema for a round-based learning management system
  designed for USCPA FAR preparation using Abitus materials.

  ## Tables Created

  1. **chapters**
     - Stores FAR chapters (e.g., Chapter 1-10)
     - Includes lecture duration for Round 1 planning
     - Fields: id, chapter_number, title, lecture_duration_minutes, order_index

  2. **tasks**
     - Stores all learning tasks (lectures, MC problems, TBS problems)
     - Each task belongs to a chapter
     - Tasks unlock at specific rounds (Round 1 for lectures, Round 2 for MC, Round 4 for TBS)
     - Fields: id, chapter_id, task_type, task_code, title, round_unlock, order_index

  3. **task_progress**
     - Tracks user progress for each task across multiple rounds
     - Records results (correct/incorrect), review dates, and completion status
     - Fields: id, task_id, current_round, status, last_result, last_completed_at, next_review_date, attempt_count

  4. **user_settings**
     - Stores global learning configuration
     - Tracks current round and round start dates
     - Fields: id, current_round, daily_task_limit, round_1_start_date, round_2_start_date, round_3_start_date, round_4_start_date

  ## Security
  - RLS enabled on all tables
  - Public access for single-user application (to be restricted in production)
*/

-- Create chapters table
CREATE TABLE IF NOT EXISTS chapters (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  chapter_number int UNIQUE NOT NULL,
  title text NOT NULL,
  lecture_duration_minutes int DEFAULT 60,
  order_index int NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create tasks table
CREATE TABLE IF NOT EXISTS tasks (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  chapter_id uuid REFERENCES chapters(id) ON DELETE CASCADE,
  task_type text NOT NULL CHECK (task_type IN ('lecture', 'mc', 'tbs')),
  task_code text UNIQUE NOT NULL,
  title text NOT NULL,
  round_unlock int NOT NULL CHECK (round_unlock IN (1, 2, 3, 4)),
  order_index int NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create task_progress table
CREATE TABLE IF NOT EXISTS task_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id uuid REFERENCES tasks(id) ON DELETE CASCADE,
  current_round int NOT NULL DEFAULT 1 CHECK (current_round >= 1 AND current_round <= 4),
  status text NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'active', 'completed')),
  last_result text CHECK (last_result IN ('correct', 'incorrect')),
  last_completed_at timestamptz,
  next_review_date date,
  attempt_count int DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(task_id, current_round)
);

-- Create user_settings table
CREATE TABLE IF NOT EXISTS user_settings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  current_round int NOT NULL DEFAULT 1 CHECK (current_round >= 1 AND current_round <= 4),
  daily_task_limit int DEFAULT 5,
  round_1_start_date date DEFAULT CURRENT_DATE,
  round_2_start_date date,
  round_3_start_date date,
  round_4_start_date date,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_tasks_chapter_id ON tasks(chapter_id);
CREATE INDEX IF NOT EXISTS idx_tasks_round_unlock ON tasks(round_unlock);
CREATE INDEX IF NOT EXISTS idx_task_progress_task_id ON task_progress(task_id);
CREATE INDEX IF NOT EXISTS idx_task_progress_status ON task_progress(status);
CREATE INDEX IF NOT EXISTS idx_task_progress_next_review_date ON task_progress(next_review_date);

-- Enable Row Level Security
ALTER TABLE chapters ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE task_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_settings ENABLE ROW LEVEL SECURITY;

-- Create policies (public access for single-user app)
CREATE POLICY "Allow public read access on chapters"
  ON chapters FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public insert on chapters"
  ON chapters FOR INSERT
  TO public
  WITH CHECK (true);

CREATE POLICY "Allow public update on chapters"
  ON chapters FOR UPDATE
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow public delete on chapters"
  ON chapters FOR DELETE
  TO public
  USING (true);

CREATE POLICY "Allow public read access on tasks"
  ON tasks FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public insert on tasks"
  ON tasks FOR INSERT
  TO public
  WITH CHECK (true);

CREATE POLICY "Allow public update on tasks"
  ON tasks FOR UPDATE
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow public delete on tasks"
  ON tasks FOR DELETE
  TO public
  USING (true);

CREATE POLICY "Allow public read access on task_progress"
  ON task_progress FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public insert on task_progress"
  ON task_progress FOR INSERT
  TO public
  WITH CHECK (true);

CREATE POLICY "Allow public update on task_progress"
  ON task_progress FOR UPDATE
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow public delete on task_progress"
  ON task_progress FOR DELETE
  TO public
  USING (true);

CREATE POLICY "Allow public read access on user_settings"
  ON user_settings FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public insert on user_settings"
  ON user_settings FOR INSERT
  TO public
  WITH CHECK (true);

CREATE POLICY "Allow public update on user_settings"
  ON user_settings FOR UPDATE
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow public delete on user_settings"
  ON user_settings FOR DELETE
  TO public
  USING (true);

-- Insert default user settings
INSERT INTO user_settings (current_round, daily_task_limit, round_1_start_date)
VALUES (1, 5, CURRENT_DATE)
ON CONFLICT DO NOTHING;