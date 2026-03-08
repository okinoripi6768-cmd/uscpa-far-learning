/*
  # Update Chapter 3 MC Problems with Section Links

  1. Updates
    - Update existing 10 MC problems (MC3-01 to MC3-10) with new task codes and lecture links
    - Add 51 new MC problems for remaining sections
    - Total: 61 MC problems across 23 sections
    
  2. Existing Tasks Updated (10)
    - MC3-01 → M3-2-1 (Section 2: lecture_number 1)
    - MC3-02 → M3-2-2 (Section 2: lecture_number 1)
    - MC3-03 → M3-2-3 (Section 2: lecture_number 1)
    - MC3-04 → M3-4-1 (Section 4: lecture_number 3)
    - MC3-05 → M3-4-2 (Section 4: lecture_number 3)
    - MC3-06 → M3-4-3 (Section 4: lecture_number 3)
    - MC3-07 → M3-4-4 (Section 4: lecture_number 3)
    - MC3-08 → M3-5-1 (Section 5: lecture_number 4)
    - MC3-09 → M3-6-1 (Section 6: lecture_number 5)
    - MC3-10 → M3-6-2 (Section 6: lecture_number 5)
    
  3. New Tasks Added (51)
    - Section 6: M3-6-3
    - Section 7: M3-7-1, M3-7-2
    - Section 8: M3-8-1 to M3-8-7 (7 tasks)
    - Section 9: M3-9-1, M3-9-2
    - Section 10: M3-10-1, M3-10-2
    - Section 11: M3-11-1
    - Section 12: M3-12-1
    - Section 13: M3-13-1
    - Section 14: M3-14-1, M3-14-2
    - Section 15: M3-15-1 to M3-15-4 (4 tasks)
    - Section 16: M3-16-1, M3-16-2
    - Section 18: M3-18-1
    - Section 19: M3-19-1, M3-19-2
    - Section 20: M3-20-1 to M3-20-3 (3 tasks)
    - Section 21: M3-21-1 to M3-21-4 (4 tasks)
    - Section 22: M3-22-1 to M3-22-6 (6 tasks)
    - Section 23: M3-23-1 to M3-23-6 (6 tasks)
    - Section 24: M3-24-1, M3-24-2
    - Section 25: M3-25-1, M3-25-2
    - Section 27: M3-27-1
*/

DO $$
DECLARE
  chapter3_id uuid;
  lecture_ids uuid[];
BEGIN
  SELECT id INTO chapter3_id FROM chapters WHERE chapter_number = 3;
  
  SELECT ARRAY_AGG(id ORDER BY lecture_number) INTO lecture_ids
  FROM lectures 
  WHERE chapter_id = chapter3_id;

  -- Update existing 10 tasks
  UPDATE tasks 
  SET task_code = 'M3-2-1', 
      title = 'Chapter 3 Section 2 MC問題 1',
      lecture_id = lecture_ids[2]
  WHERE task_code = 'MC3-01' AND chapter_id = chapter3_id;

  UPDATE tasks 
  SET task_code = 'M3-2-2', 
      title = 'Chapter 3 Section 2 MC問題 2',
      lecture_id = lecture_ids[2]
  WHERE task_code = 'MC3-02' AND chapter_id = chapter3_id;

  UPDATE tasks 
  SET task_code = 'M3-2-3', 
      title = 'Chapter 3 Section 2 MC問題 3',
      lecture_id = lecture_ids[2]
  WHERE task_code = 'MC3-03' AND chapter_id = chapter3_id;

  UPDATE tasks 
  SET task_code = 'M3-4-1', 
      title = 'Chapter 3 Section 4 MC問題 1',
      lecture_id = lecture_ids[4]
  WHERE task_code = 'MC3-04' AND chapter_id = chapter3_id;

  UPDATE tasks 
  SET task_code = 'M3-4-2', 
      title = 'Chapter 3 Section 4 MC問題 2',
      lecture_id = lecture_ids[4]
  WHERE task_code = 'MC3-05' AND chapter_id = chapter3_id;

  UPDATE tasks 
  SET task_code = 'M3-4-3', 
      title = 'Chapter 3 Section 4 MC問題 3',
      lecture_id = lecture_ids[4]
  WHERE task_code = 'MC3-06' AND chapter_id = chapter3_id;

  UPDATE tasks 
  SET task_code = 'M3-4-4', 
      title = 'Chapter 3 Section 4 MC問題 4',
      lecture_id = lecture_ids[4]
  WHERE task_code = 'MC3-07' AND chapter_id = chapter3_id;

  UPDATE tasks 
  SET task_code = 'M3-5-1', 
      title = 'Chapter 3 Section 5 MC問題 1',
      lecture_id = lecture_ids[5]
  WHERE task_code = 'MC3-08' AND chapter_id = chapter3_id;

  UPDATE tasks 
  SET task_code = 'M3-6-1', 
      title = 'Chapter 3 Section 6 MC問題 1',
      lecture_id = lecture_ids[6]
  WHERE task_code = 'MC3-09' AND chapter_id = chapter3_id;

  UPDATE tasks 
  SET task_code = 'M3-6-2', 
      title = 'Chapter 3 Section 6 MC問題 2',
      lecture_id = lecture_ids[6]
  WHERE task_code = 'MC3-10' AND chapter_id = chapter3_id;

  -- Insert new tasks (51 tasks)
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES
    -- Section 6 (remaining)
    (chapter3_id, lecture_ids[6], 'mc', 'M3-6-3', 'Chapter 3 Section 6 MC問題 3', 1, 310),
    
    -- Section 7
    (chapter3_id, lecture_ids[7], 'mc', 'M3-7-1', 'Chapter 3 Section 7 MC問題 1', 1, 311),
    (chapter3_id, lecture_ids[7], 'mc', 'M3-7-2', 'Chapter 3 Section 7 MC問題 2', 1, 312),
    
    -- Section 8
    (chapter3_id, lecture_ids[8], 'mc', 'M3-8-1', 'Chapter 3 Section 8 MC問題 1', 1, 313),
    (chapter3_id, lecture_ids[8], 'mc', 'M3-8-2', 'Chapter 3 Section 8 MC問題 2', 1, 314),
    (chapter3_id, lecture_ids[8], 'mc', 'M3-8-3', 'Chapter 3 Section 8 MC問題 3', 1, 315),
    (chapter3_id, lecture_ids[8], 'mc', 'M3-8-4', 'Chapter 3 Section 8 MC問題 4', 1, 316),
    (chapter3_id, lecture_ids[8], 'mc', 'M3-8-5', 'Chapter 3 Section 8 MC問題 5', 1, 317),
    (chapter3_id, lecture_ids[8], 'mc', 'M3-8-6', 'Chapter 3 Section 8 MC問題 6', 1, 318),
    (chapter3_id, lecture_ids[8], 'mc', 'M3-8-7', 'Chapter 3 Section 8 MC問題 7', 1, 319),
    
    -- Section 9
    (chapter3_id, lecture_ids[9], 'mc', 'M3-9-1', 'Chapter 3 Section 9 MC問題 1', 1, 320),
    (chapter3_id, lecture_ids[9], 'mc', 'M3-9-2', 'Chapter 3 Section 9 MC問題 2', 1, 321),
    
    -- Section 10
    (chapter3_id, lecture_ids[10], 'mc', 'M3-10-1', 'Chapter 3 Section 10 MC問題 1', 1, 322),
    (chapter3_id, lecture_ids[10], 'mc', 'M3-10-2', 'Chapter 3 Section 10 MC問題 2', 1, 323),
    
    -- Section 11
    (chapter3_id, lecture_ids[11], 'mc', 'M3-11-1', 'Chapter 3 Section 11 MC問題 1', 1, 324),
    
    -- Section 12
    (chapter3_id, lecture_ids[12], 'mc', 'M3-12-1', 'Chapter 3 Section 12 MC問題 1', 1, 325),
    
    -- Section 13
    (chapter3_id, lecture_ids[13], 'mc', 'M3-13-1', 'Chapter 3 Section 13 MC問題 1', 1, 326),
    
    -- Section 14
    (chapter3_id, lecture_ids[14], 'mc', 'M3-14-1', 'Chapter 3 Section 14 MC問題 1', 1, 327),
    (chapter3_id, lecture_ids[14], 'mc', 'M3-14-2', 'Chapter 3 Section 14 MC問題 2', 1, 328),
    
    -- Section 15
    (chapter3_id, lecture_ids[15], 'mc', 'M3-15-1', 'Chapter 3 Section 15 MC問題 1', 1, 329),
    (chapter3_id, lecture_ids[15], 'mc', 'M3-15-2', 'Chapter 3 Section 15 MC問題 2', 1, 330),
    (chapter3_id, lecture_ids[15], 'mc', 'M3-15-3', 'Chapter 3 Section 15 MC問題 3', 1, 331),
    (chapter3_id, lecture_ids[15], 'mc', 'M3-15-4', 'Chapter 3 Section 15 MC問題 4', 1, 332),
    
    -- Section 16
    (chapter3_id, lecture_ids[16], 'mc', 'M3-16-1', 'Chapter 3 Section 16 MC問題 1', 1, 333),
    (chapter3_id, lecture_ids[16], 'mc', 'M3-16-2', 'Chapter 3 Section 16 MC問題 2', 1, 334),
    
    -- Section 18
    (chapter3_id, lecture_ids[18], 'mc', 'M3-18-1', 'Chapter 3 Section 18 MC問題 1', 1, 335),
    
    -- Section 19
    (chapter3_id, lecture_ids[19], 'mc', 'M3-19-1', 'Chapter 3 Section 19 MC問題 1', 1, 336),
    (chapter3_id, lecture_ids[19], 'mc', 'M3-19-2', 'Chapter 3 Section 19 MC問題 2', 1, 337),
    
    -- Section 20
    (chapter3_id, lecture_ids[20], 'mc', 'M3-20-1', 'Chapter 3 Section 20 MC問題 1', 1, 338),
    (chapter3_id, lecture_ids[20], 'mc', 'M3-20-2', 'Chapter 3 Section 20 MC問題 2', 1, 339),
    (chapter3_id, lecture_ids[20], 'mc', 'M3-20-3', 'Chapter 3 Section 20 MC問題 3', 1, 340),
    
    -- Section 21
    (chapter3_id, lecture_ids[21], 'mc', 'M3-21-1', 'Chapter 3 Section 21 MC問題 1', 1, 341),
    (chapter3_id, lecture_ids[21], 'mc', 'M3-21-2', 'Chapter 3 Section 21 MC問題 2', 1, 342),
    (chapter3_id, lecture_ids[21], 'mc', 'M3-21-3', 'Chapter 3 Section 21 MC問題 3', 1, 343),
    (chapter3_id, lecture_ids[21], 'mc', 'M3-21-4', 'Chapter 3 Section 21 MC問題 4', 1, 344),
    
    -- Section 22
    (chapter3_id, lecture_ids[22], 'mc', 'M3-22-1', 'Chapter 3 Section 22 MC問題 1', 1, 345),
    (chapter3_id, lecture_ids[22], 'mc', 'M3-22-2', 'Chapter 3 Section 22 MC問題 2', 1, 346),
    (chapter3_id, lecture_ids[22], 'mc', 'M3-22-3', 'Chapter 3 Section 22 MC問題 3', 1, 347),
    (chapter3_id, lecture_ids[22], 'mc', 'M3-22-4', 'Chapter 3 Section 22 MC問題 4', 1, 348),
    (chapter3_id, lecture_ids[22], 'mc', 'M3-22-5', 'Chapter 3 Section 22 MC問題 5', 1, 349),
    (chapter3_id, lecture_ids[22], 'mc', 'M3-22-6', 'Chapter 3 Section 22 MC問題 6', 1, 350),
    
    -- Section 23
    (chapter3_id, lecture_ids[23], 'mc', 'M3-23-1', 'Chapter 3 Section 23 MC問題 1', 1, 351),
    (chapter3_id, lecture_ids[23], 'mc', 'M3-23-2', 'Chapter 3 Section 23 MC問題 2', 1, 352),
    (chapter3_id, lecture_ids[23], 'mc', 'M3-23-3', 'Chapter 3 Section 23 MC問題 3', 1, 353),
    (chapter3_id, lecture_ids[23], 'mc', 'M3-23-4', 'Chapter 3 Section 23 MC問題 4', 1, 354),
    (chapter3_id, lecture_ids[23], 'mc', 'M3-23-5', 'Chapter 3 Section 23 MC問題 5', 1, 355),
    (chapter3_id, lecture_ids[23], 'mc', 'M3-23-6', 'Chapter 3 Section 23 MC問題 6', 1, 356),
    
    -- Section 24
    (chapter3_id, lecture_ids[24], 'mc', 'M3-24-1', 'Chapter 3 Section 24 MC問題 1', 1, 357),
    (chapter3_id, lecture_ids[24], 'mc', 'M3-24-2', 'Chapter 3 Section 24 MC問題 2', 1, 358),
    
    -- Section 25
    (chapter3_id, lecture_ids[25], 'mc', 'M3-25-1', 'Chapter 3 Section 25 MC問題 1', 1, 359),
    (chapter3_id, lecture_ids[25], 'mc', 'M3-25-2', 'Chapter 3 Section 25 MC問題 2', 1, 360),
    
    -- Section 27
    (chapter3_id, lecture_ids[27], 'mc', 'M3-27-1', 'Chapter 3 Section 27 MC問題 1', 1, 361);
END $$;
