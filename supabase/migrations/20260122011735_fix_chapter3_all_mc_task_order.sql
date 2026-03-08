/*
  # Fix Chapter 3 All MC Task Ordering
  
  1. Problem
    - MC tasks for Sections 3, 4, and 5 have incorrect order_index values
    - MC tasks should appear immediately after their corresponding lecture
    - Many tasks are currently placed after subsequent lectures
  
  2. Changes
    - Update order_index for all misplaced MC tasks in Chapter 3
    - Ensure tasks appear in correct sequence: Lecture -> MC tasks -> TBS task
  
  3. Section-by-Section Corrections
    - Section 3: M3-4-1 to M3-4-4 should follow L3-03
    - Section 4: M3-5-1 should follow L3-04
    - Section 5: M3-6-3 should follow L3-05
*/

DO $$
DECLARE
  v_chapter_id uuid;
BEGIN
  -- Get Chapter 3 ID
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 3;
  
  -- Section 3: Fix M3-4-1 through M3-4-4
  UPDATE tasks SET order_index = 30302 WHERE chapter_id = v_chapter_id AND task_code = 'M3-4-1';
  UPDATE tasks SET order_index = 30303 WHERE chapter_id = v_chapter_id AND task_code = 'M3-4-2';
  UPDATE tasks SET order_index = 30304 WHERE chapter_id = v_chapter_id AND task_code = 'M3-4-3';
  UPDATE tasks SET order_index = 30305 WHERE chapter_id = v_chapter_id AND task_code = 'M3-4-4';
  UPDATE tasks SET order_index = 30306 WHERE chapter_id = v_chapter_id AND task_code = 'TBS3-03';
  
  -- Section 4: Fix M3-5-1
  -- L3-04 is at 30401, so M3-5-1 should be 30402, TBS3-04 at 30403 (already correct)
  UPDATE tasks SET order_index = 30402 WHERE chapter_id = v_chapter_id AND task_code = 'M3-5-1';
  
  -- Section 5: Fix M3-6-3 (Round 1 MC task)
  -- L3-05 is at 30501, so M3-6-3 should be 30502, TBS3-05 at 30503 (already correct)
  UPDATE tasks SET order_index = 30502 WHERE chapter_id = v_chapter_id AND task_code = 'M3-6-3';
  
  -- Reorder Section 2: TBS3-02 should come after all Section 2 tasks
  -- L3-02 is at 30201, so TBS3-02 should be at 30202
  UPDATE tasks SET order_index = 30202 WHERE chapter_id = v_chapter_id AND task_code = 'TBS3-02';
  
END $$;
