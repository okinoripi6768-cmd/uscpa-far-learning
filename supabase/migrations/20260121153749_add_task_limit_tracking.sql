/*
  # Add Task Limit Tracking Fields

  ## Changes
  1. Add tracking fields to user_settings table:
     - `original_daily_task_limit` - User's preferred task limit (baseline)
     - `last_completion_check_date` - Last date when completion was checked
     - `consecutive_completion_days` - Number of days tasks were fully completed

  ## Purpose
  These fields enable automatic task limit adjustment:
  - If user can't complete tasks, limit decreases automatically
  - Tracks original preference to know what to restore to
  - Monitors completion patterns for intelligent adjustment
*/

-- Add new columns to user_settings
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'user_settings' AND column_name = 'original_daily_task_limit'
  ) THEN
    ALTER TABLE user_settings ADD COLUMN original_daily_task_limit int DEFAULT 5;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'user_settings' AND column_name = 'last_completion_check_date'
  ) THEN
    ALTER TABLE user_settings ADD COLUMN last_completion_check_date date;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'user_settings' AND column_name = 'consecutive_completion_days'
  ) THEN
    ALTER TABLE user_settings ADD COLUMN consecutive_completion_days int DEFAULT 0;
  END IF;
END $$;

-- Set original_daily_task_limit to current daily_task_limit for existing records
UPDATE user_settings
SET original_daily_task_limit = daily_task_limit
WHERE original_daily_task_limit IS NULL OR original_daily_task_limit = 0;