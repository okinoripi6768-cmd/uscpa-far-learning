/*
  # Fix Chapter 3 Section 6 MC問題 task order

  1. Changes
    - Move M3-6-1 and M3-6-2 to appear after L3-05 (主な支払い条件と売掛金の評価)
    - Update order_index for M3-6-1, M3-6-2, M3-6-3 to be sequential after L3-05
    - Update round_unlock for M3-6-1 and M3-6-2 from 2 to 1
    - Adjust TBS3-05 order_index accordingly
    
  2. Notes
    - M3-5-1 is at order_index 30402
    - L3-05 is at order_index 30501
    - M3-6-1, M3-6-2, M3-6-3 should follow L3-05 at 30502, 30503, 30504
    - TBS3-05 moves to 30505
*/

UPDATE tasks 
SET order_index = 30502, round_unlock = 1
WHERE task_code = 'M3-6-1';

UPDATE tasks 
SET order_index = 30503, round_unlock = 1
WHERE task_code = 'M3-6-2';

UPDATE tasks 
SET order_index = 30504
WHERE task_code = 'M3-6-3';

UPDATE tasks 
SET order_index = 30505
WHERE task_code = 'TBS3-05';