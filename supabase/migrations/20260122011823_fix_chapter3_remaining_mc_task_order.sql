/*
  # Fix Chapter 3 Remaining MC Task Ordering
  
  1. Problem
    - MC tasks for Sections 6-27 have old order_index values (311-361)
    - These tasks should appear after their corresponding lectures
  
  2. Changes
    - Update order_index for all remaining MC tasks in Chapter 3
    - Place MC tasks immediately after their corresponding lectures
  
  3. Section-by-Section Corrections
    - Section 6: M3-7-1, M3-7-2 after L3-06 (30601)
    - Section 7: M3-8-1 to M3-8-7 after L3-07 (30701)
    - Section 8: M3-9-1, M3-9-2 after L3-08 (30801)
    - Section 9: M3-10-1, M3-10-2 after L3-09 (30901)
    - Section 10: M3-11-1 after L3-10 (31001)
    - Section 11: M3-12-1 after L3-11 (31101)
    - Section 12: M3-13-1 after L3-12 (31201)
    - Section 13: M3-14-1, M3-14-2 after L3-13 (31301)
    - Section 14: M3-15-1 to M3-15-4 after L3-14 (31401)
    - Section 15: M3-16-1, M3-16-2 after L3-15 (31501)
    - Section 17: M3-18-1 after L3-17 (31701)
    - Section 18: M3-19-1, M3-19-2 after L3-18 (31801)
    - Section 19: M3-20-1 to M3-20-3 after L3-19 (31901)
    - Section 20: M3-21-1 to M3-21-4 after L3-20 (32001)
    - Section 21: M3-22-1 to M3-22-6 after L3-21 (32101)
    - Section 22: M3-23-1 to M3-23-6 after L3-22 (32201)
    - Section 23: M3-24-1, M3-24-2 after L3-23 (32301)
    - Section 24: M3-25-1, M3-25-2 after L3-24 (32401)
    - Section 26: M3-27-1 after L3-26 (32601)
*/

DO $$
DECLARE
  v_chapter_id uuid;
BEGIN
  -- Get Chapter 3 ID
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 3;
  
  -- Section 6: L3-06 (30601)
  UPDATE tasks SET order_index = 30602 WHERE chapter_id = v_chapter_id AND task_code = 'M3-7-1';
  UPDATE tasks SET order_index = 30603 WHERE chapter_id = v_chapter_id AND task_code = 'M3-7-2';
  
  -- Section 7: L3-07 (30701)
  UPDATE tasks SET order_index = 30702 WHERE chapter_id = v_chapter_id AND task_code = 'M3-8-1';
  UPDATE tasks SET order_index = 30703 WHERE chapter_id = v_chapter_id AND task_code = 'M3-8-2';
  UPDATE tasks SET order_index = 30704 WHERE chapter_id = v_chapter_id AND task_code = 'M3-8-3';
  UPDATE tasks SET order_index = 30705 WHERE chapter_id = v_chapter_id AND task_code = 'M3-8-4';
  UPDATE tasks SET order_index = 30706 WHERE chapter_id = v_chapter_id AND task_code = 'M3-8-5';
  UPDATE tasks SET order_index = 30707 WHERE chapter_id = v_chapter_id AND task_code = 'M3-8-6';
  UPDATE tasks SET order_index = 30708 WHERE chapter_id = v_chapter_id AND task_code = 'M3-8-7';
  
  -- Section 8: L3-08 (30801)
  UPDATE tasks SET order_index = 30802 WHERE chapter_id = v_chapter_id AND task_code = 'M3-9-1';
  UPDATE tasks SET order_index = 30803 WHERE chapter_id = v_chapter_id AND task_code = 'M3-9-2';
  
  -- Section 9: L3-09 (30901)
  UPDATE tasks SET order_index = 30902 WHERE chapter_id = v_chapter_id AND task_code = 'M3-10-1';
  UPDATE tasks SET order_index = 30903 WHERE chapter_id = v_chapter_id AND task_code = 'M3-10-2';
  
  -- Section 10: L3-10 (31001)
  UPDATE tasks SET order_index = 31002 WHERE chapter_id = v_chapter_id AND task_code = 'M3-11-1';
  
  -- Section 11: L3-11 (31101)
  UPDATE tasks SET order_index = 31102 WHERE chapter_id = v_chapter_id AND task_code = 'M3-12-1';
  
  -- Section 12: L3-12 (31201)
  UPDATE tasks SET order_index = 31202 WHERE chapter_id = v_chapter_id AND task_code = 'M3-13-1';
  
  -- Section 13: L3-13 (31301)
  UPDATE tasks SET order_index = 31302 WHERE chapter_id = v_chapter_id AND task_code = 'M3-14-1';
  UPDATE tasks SET order_index = 31303 WHERE chapter_id = v_chapter_id AND task_code = 'M3-14-2';
  
  -- Section 14: L3-14 (31401)
  UPDATE tasks SET order_index = 31402 WHERE chapter_id = v_chapter_id AND task_code = 'M3-15-1';
  UPDATE tasks SET order_index = 31403 WHERE chapter_id = v_chapter_id AND task_code = 'M3-15-2';
  UPDATE tasks SET order_index = 31404 WHERE chapter_id = v_chapter_id AND task_code = 'M3-15-3';
  UPDATE tasks SET order_index = 31405 WHERE chapter_id = v_chapter_id AND task_code = 'M3-15-4';
  
  -- Section 15: L3-15 (31501)
  UPDATE tasks SET order_index = 31502 WHERE chapter_id = v_chapter_id AND task_code = 'M3-16-1';
  UPDATE tasks SET order_index = 31503 WHERE chapter_id = v_chapter_id AND task_code = 'M3-16-2';
  
  -- Section 17: L3-17 (31701)
  UPDATE tasks SET order_index = 31702 WHERE chapter_id = v_chapter_id AND task_code = 'M3-18-1';
  
  -- Section 18: L3-18 (31801)
  UPDATE tasks SET order_index = 31802 WHERE chapter_id = v_chapter_id AND task_code = 'M3-19-1';
  UPDATE tasks SET order_index = 31803 WHERE chapter_id = v_chapter_id AND task_code = 'M3-19-2';
  
  -- Section 19: L3-19 (31901)
  UPDATE tasks SET order_index = 31902 WHERE chapter_id = v_chapter_id AND task_code = 'M3-20-1';
  UPDATE tasks SET order_index = 31903 WHERE chapter_id = v_chapter_id AND task_code = 'M3-20-2';
  UPDATE tasks SET order_index = 31904 WHERE chapter_id = v_chapter_id AND task_code = 'M3-20-3';
  
  -- Section 20: L3-20 (32001)
  UPDATE tasks SET order_index = 32002 WHERE chapter_id = v_chapter_id AND task_code = 'M3-21-1';
  UPDATE tasks SET order_index = 32003 WHERE chapter_id = v_chapter_id AND task_code = 'M3-21-2';
  UPDATE tasks SET order_index = 32004 WHERE chapter_id = v_chapter_id AND task_code = 'M3-21-3';
  UPDATE tasks SET order_index = 32005 WHERE chapter_id = v_chapter_id AND task_code = 'M3-21-4';
  
  -- Section 21: L3-21 (32101)
  UPDATE tasks SET order_index = 32102 WHERE chapter_id = v_chapter_id AND task_code = 'M3-22-1';
  UPDATE tasks SET order_index = 32103 WHERE chapter_id = v_chapter_id AND task_code = 'M3-22-2';
  UPDATE tasks SET order_index = 32104 WHERE chapter_id = v_chapter_id AND task_code = 'M3-22-3';
  UPDATE tasks SET order_index = 32105 WHERE chapter_id = v_chapter_id AND task_code = 'M3-22-4';
  UPDATE tasks SET order_index = 32106 WHERE chapter_id = v_chapter_id AND task_code = 'M3-22-5';
  UPDATE tasks SET order_index = 32107 WHERE chapter_id = v_chapter_id AND task_code = 'M3-22-6';
  
  -- Section 22: L3-22 (32201)
  UPDATE tasks SET order_index = 32202 WHERE chapter_id = v_chapter_id AND task_code = 'M3-23-1';
  UPDATE tasks SET order_index = 32203 WHERE chapter_id = v_chapter_id AND task_code = 'M3-23-2';
  UPDATE tasks SET order_index = 32204 WHERE chapter_id = v_chapter_id AND task_code = 'M3-23-3';
  UPDATE tasks SET order_index = 32205 WHERE chapter_id = v_chapter_id AND task_code = 'M3-23-4';
  UPDATE tasks SET order_index = 32206 WHERE chapter_id = v_chapter_id AND task_code = 'M3-23-5';
  UPDATE tasks SET order_index = 32207 WHERE chapter_id = v_chapter_id AND task_code = 'M3-23-6';
  
  -- Section 23: L3-23 (32301)
  UPDATE tasks SET order_index = 32302 WHERE chapter_id = v_chapter_id AND task_code = 'M3-24-1';
  UPDATE tasks SET order_index = 32303 WHERE chapter_id = v_chapter_id AND task_code = 'M3-24-2';
  
  -- Section 24: L3-24 (32401)
  UPDATE tasks SET order_index = 32402 WHERE chapter_id = v_chapter_id AND task_code = 'M3-25-1';
  UPDATE tasks SET order_index = 32403 WHERE chapter_id = v_chapter_id AND task_code = 'M3-25-2';
  
  -- Section 26: L3-26 (32601)
  UPDATE tasks SET order_index = 32602 WHERE chapter_id = v_chapter_id AND task_code = 'M3-27-1';
  
END $$;
