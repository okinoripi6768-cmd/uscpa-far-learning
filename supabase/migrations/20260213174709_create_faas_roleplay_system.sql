/*
  # Create FAAS Roleplay System for Section 3

  ## Summary
  Transforms Section 3 from flashcards to interactive FAAS roleplay scenarios

  ## New Tables
  1. `faas_roleplay_scenarios`
    - Stores roleplay scenarios for each chapter
    - Includes scenario description, roles, conversation flow
    - Contains model answers and hints
  
  2. `faas_roleplay_progress`
    - Tracks user progress through roleplay scenarios
    - Records completion, notes, and practice history

  ## Features
  - Scenario-based learning for Big4 FAAS preparation
  - Client meeting simulations
  - Technical accounting explanations practice
  - CEFR B1-B2 level appropriate content

  ## Migration Strategy
  - Creates new tables alongside existing ones
  - Existing practical_english tables remain for data safety
  - Frontend will be updated to use new system
*/

-- Create roleplay scenarios table
CREATE TABLE IF NOT EXISTS faas_roleplay_scenarios (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  chapter_id uuid NOT NULL REFERENCES chapters(id) ON DELETE CASCADE,
  
  -- Scenario details
  scenario_title text NOT NULL,
  scenario_description text NOT NULL,
  accounting_topic text NOT NULL,
  
  -- Roles
  consultant_role text NOT NULL DEFAULT 'FAAS Consultant',
  client_role text NOT NULL DEFAULT 'Client CFO',
  
  -- Key vocabulary
  key_vocabulary jsonb NOT NULL DEFAULT '[]',
  
  -- Conversation flow
  step1_client_question text NOT NULL,
  step2_explanation_prompt text NOT NULL,
  step3_followup_question text NOT NULL,
  
  -- Model answers
  model_answer_step2 text NOT NULL,
  model_answer_step3 text NOT NULL,
  
  -- Support materials
  japanese_hints text,
  technical_references text,
  
  -- Metadata
  difficulty text NOT NULL CHECK (difficulty IN ('basic', 'intermediate', 'advanced')) DEFAULT 'intermediate',
  estimated_time_minutes int DEFAULT 10,
  order_index int NOT NULL DEFAULT 0,
  
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create progress tracking table
CREATE TABLE IF NOT EXISTS faas_roleplay_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  scenario_id uuid NOT NULL REFERENCES faas_roleplay_scenarios(id) ON DELETE CASCADE,
  
  -- Progress data
  completed boolean DEFAULT false,
  attempts int DEFAULT 0,
  last_practiced_at timestamptz,
  
  -- User notes
  my_answer_step2 text,
  my_answer_step3 text,
  personal_notes text,
  
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  
  UNIQUE(user_id, scenario_id)
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_faas_scenarios_chapter ON faas_roleplay_scenarios(chapter_id);
CREATE INDEX IF NOT EXISTS idx_faas_scenarios_order ON faas_roleplay_scenarios(order_index);
CREATE INDEX IF NOT EXISTS idx_faas_progress_user ON faas_roleplay_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_faas_progress_scenario ON faas_roleplay_progress(scenario_id);

-- Enable RLS
ALTER TABLE faas_roleplay_scenarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE faas_roleplay_progress ENABLE ROW LEVEL SECURITY;

-- RLS Policies for scenarios (public read)
CREATE POLICY "Anyone can view roleplay scenarios"
  ON faas_roleplay_scenarios FOR SELECT
  TO public
  USING (true);

-- RLS Policies for progress
CREATE POLICY "Users can view own roleplay progress"
  ON faas_roleplay_progress FOR SELECT
  TO public
  USING (user_id IS NULL OR auth.uid() = user_id);

CREATE POLICY "Users can insert own roleplay progress"
  ON faas_roleplay_progress FOR INSERT
  TO public
  WITH CHECK (user_id IS NULL OR auth.uid() = user_id);

CREATE POLICY "Users can update own roleplay progress"
  ON faas_roleplay_progress FOR UPDATE
  TO public
  USING (user_id IS NULL OR auth.uid() = user_id)
  WITH CHECK (user_id IS NULL OR auth.uid() = user_id);

CREATE POLICY "Users can delete own roleplay progress"
  ON faas_roleplay_progress FOR DELETE
  TO public
  USING (user_id IS NULL OR auth.uid() = user_id);