/*
  # Fix Chapter 3 MC Tasks Round Unlock
  
  1. Changes
    - Update round_unlock to 1 for tasks M3-2-1, M3-2-2, M3-2-3, M3-4-1, M3-4-2, M3-4-3, M3-4-4, M3-5-1
    - These tasks were updated from MC3-01 to MC3-10 but kept their original round_unlock value of 2
    - This fix ensures they are available in Round 1 like the other newly added tasks
*/

UPDATE tasks
SET round_unlock = 1
WHERE chapter_id = (SELECT id FROM chapters WHERE chapter_number = 3)
  AND task_type = 'mc'
  AND task_code IN ('M3-2-1', 'M3-2-2', 'M3-2-3', 'M3-4-1', 'M3-4-2', 'M3-4-3', 'M3-4-4', 'M3-5-1');
