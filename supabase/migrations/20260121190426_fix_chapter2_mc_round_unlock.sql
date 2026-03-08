/*
  # Fix Chapter 2 MC Tasks Round Unlock
  
  1. Changes
    - Update round_unlock to 1 for Section 2-1 through 2-5 tasks
    - Tasks: M2-1-1, M2-1-2, M2-1-3, M2-2-1, M2-2-2, M2-3-1, M2-3-2, M2-4-1, M2-5-1, M2-5-2
    - These tasks were incorrectly set to round_unlock = 2
    - This fix ensures they are available in Round 1 for proper display in the modal
*/

UPDATE tasks
SET round_unlock = 1
WHERE chapter_id = (SELECT id FROM chapters WHERE chapter_number = 2)
  AND task_type = 'mc'
  AND task_code IN ('M2-1-1', 'M2-1-2', 'M2-1-3', 'M2-2-1', 'M2-2-2', 'M2-3-1', 'M2-3-2', 'M2-4-1', 'M2-5-1', 'M2-5-2');
