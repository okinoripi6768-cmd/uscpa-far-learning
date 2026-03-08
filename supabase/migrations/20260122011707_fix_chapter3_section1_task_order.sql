/*
  # Fix Chapter 3 Section 1 Task Ordering
  
  1. Problem
    - MC tasks for Section 1 (M3-2-1, M3-2-2, M3-2-3) have incorrect order_index values
    - These tasks should appear right after L3-01 lecture
    - Currently M3-2-2 and M3-2-3 have order_index values that place them after other lectures
  
  2. Changes
    - Update order_index for M3-2-1, M3-2-2, M3-2-3 to be sequential after L3-01
    - Adjust TBS3-01 to come after all Section 1 MC problems
  
  3. Correct Order
    - L3-01: 30101 (Lecture 1)
    - M3-2-1: 30102 (MC problem 1)
    - M3-2-2: 30103 (MC problem 2)
    - M3-2-3: 30104 (MC problem 3)
    - TBS3-01: 30105 (TBS problem)
    - L3-02: 30201 (Lecture 2)
*/

DO $$
DECLARE
  v_chapter_id uuid;
BEGIN
  -- Get Chapter 3 ID
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 3;
  
  -- Update M3-2-2 order_index (currently 30202, should be 30103)
  UPDATE tasks
  SET order_index = 30103
  WHERE chapter_id = v_chapter_id AND task_code = 'M3-2-2';
  
  -- Update M3-2-3 order_index (currently 30302, should be 30104)
  UPDATE tasks
  SET order_index = 30104
  WHERE chapter_id = v_chapter_id AND task_code = 'M3-2-3';
  
  -- Update TBS3-01 order_index (currently 30103, should be 30105)
  UPDATE tasks
  SET order_index = 30105
  WHERE chapter_id = v_chapter_id AND task_code = 'TBS3-01';
  
END $$;
