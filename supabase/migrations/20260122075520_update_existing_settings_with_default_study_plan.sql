/*
  # Update existing user settings with default study plan

  1. Changes
    - Set default 'moderate' study plan for any existing records without study_plan
    
  2. Notes
    - This ensures backward compatibility with existing data
*/

UPDATE user_settings 
SET study_plan = 'moderate' 
WHERE study_plan IS NULL;