/*
  # Update Round Unlock for Chapters 6-10 MC Tasks
  
  1. Changes
    - Update all MC tasks for Chapters 6, 7, 8, 9, and 10
    - Set round_unlock = 1 (previously was 2)
    - Makes all MC problems available in Round 1
  
  2. Affected Chapters
    - Chapter 6: 4 MC tasks
    - Chapter 7: 2 MC tasks
    - Chapter 8: 22 MC tasks
    - Chapter 9: 34 MC tasks
    - Chapter 10: 18 MC tasks
*/

UPDATE tasks
SET round_unlock = 1
WHERE chapter_id IN (
  SELECT id 
  FROM chapters 
  WHERE chapter_number IN (6, 7, 8, 9, 10)
)
AND task_type = 'mc'
AND round_unlock = 2;
