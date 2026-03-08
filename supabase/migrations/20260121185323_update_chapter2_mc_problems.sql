/*
  # Update Chapter 2 MC Problems with Section Links

  1. Updates
    - Update existing 10 MC problems (MC2-01 to MC2-10) with new task codes and lecture links
    - Add 10 new MC problems for remaining sections
    
  2. Changes
    - MC2-01 → M2-1-1 (Section 2-1)
    - MC2-02 → M2-1-2 (Section 2-1)
    - MC2-03 → M2-1-3 (Section 2-1)
    - MC2-04 → M2-2-1 (Section 2-2)
    - MC2-05 → M2-2-2 (Section 2-2)
    - MC2-06 → M2-3-1 (Section 2-3)
    - MC2-07 → M2-3-2 (Section 2-3)
    - MC2-08 → M2-4-1 (Section 2-4)
    - MC2-09 → M2-5-1 (Section 2-5)
    - MC2-10 → M2-5-2 (Section 2-5)
    
  3. New Problems Added
    - M2-8-1, M2-8-2 (Section 2-8: 非継続事業（4）開示)
    - M2-9-1 (Section 2-9: 非継続事業（5）事業継続中止の会計処理)
    - M2-10-1, M2-10-2 (Section 2-10: 非継続事業（6）会計処理と表示)
    - M2-11-01, M2-11-02 (Section 2-11: 認識と測定)
    - M2-12-1, M2-12-2, M2-12-3 (Section 2-12: 後発事象)
*/

DO $$
DECLARE
  chapter2_id uuid;
  lecture_2_1_id uuid;
  lecture_2_2_id uuid;
  lecture_2_3_id uuid;
  lecture_2_4_id uuid;
  lecture_2_5_id uuid;
  lecture_2_8_id uuid;
  lecture_2_9_id uuid;
  lecture_2_10_id uuid;
  lecture_2_11_id uuid;
  lecture_2_12_id uuid;
BEGIN
  SELECT id INTO chapter2_id FROM chapters WHERE chapter_number = 2;
  
  SELECT id INTO lecture_2_1_id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 0;
  SELECT id INTO lecture_2_2_id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 1;
  SELECT id INTO lecture_2_3_id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 2;
  SELECT id INTO lecture_2_4_id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 3;
  SELECT id INTO lecture_2_5_id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 4;
  SELECT id INTO lecture_2_8_id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 7;
  SELECT id INTO lecture_2_9_id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 8;
  SELECT id INTO lecture_2_10_id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 9;
  SELECT id INTO lecture_2_11_id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 10;
  SELECT id INTO lecture_2_12_id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 11;

  UPDATE tasks 
  SET task_code = 'M2-1-1', 
      title = 'Chapter 2 Section 1 MC問題 1',
      lecture_id = lecture_2_1_id
  WHERE task_code = 'MC2-01' AND chapter_id = chapter2_id;

  UPDATE tasks 
  SET task_code = 'M2-1-2', 
      title = 'Chapter 2 Section 1 MC問題 2',
      lecture_id = lecture_2_1_id
  WHERE task_code = 'MC2-02' AND chapter_id = chapter2_id;

  UPDATE tasks 
  SET task_code = 'M2-1-3', 
      title = 'Chapter 2 Section 1 MC問題 3',
      lecture_id = lecture_2_1_id
  WHERE task_code = 'MC2-03' AND chapter_id = chapter2_id;

  UPDATE tasks 
  SET task_code = 'M2-2-1', 
      title = 'Chapter 2 Section 2 MC問題 1',
      lecture_id = lecture_2_2_id
  WHERE task_code = 'MC2-04' AND chapter_id = chapter2_id;

  UPDATE tasks 
  SET task_code = 'M2-2-2', 
      title = 'Chapter 2 Section 2 MC問題 2',
      lecture_id = lecture_2_2_id
  WHERE task_code = 'MC2-05' AND chapter_id = chapter2_id;

  UPDATE tasks 
  SET task_code = 'M2-3-1', 
      title = 'Chapter 2 Section 3 MC問題 1',
      lecture_id = lecture_2_3_id
  WHERE task_code = 'MC2-06' AND chapter_id = chapter2_id;

  UPDATE tasks 
  SET task_code = 'M2-3-2', 
      title = 'Chapter 2 Section 3 MC問題 2',
      lecture_id = lecture_2_3_id
  WHERE task_code = 'MC2-07' AND chapter_id = chapter2_id;

  UPDATE tasks 
  SET task_code = 'M2-4-1', 
      title = 'Chapter 2 Section 4 MC問題 1',
      lecture_id = lecture_2_4_id
  WHERE task_code = 'MC2-08' AND chapter_id = chapter2_id;

  UPDATE tasks 
  SET task_code = 'M2-5-1', 
      title = 'Chapter 2 Section 5 MC問題 1',
      lecture_id = lecture_2_5_id
  WHERE task_code = 'MC2-09' AND chapter_id = chapter2_id;

  UPDATE tasks 
  SET task_code = 'M2-5-2', 
      title = 'Chapter 2 Section 5 MC問題 2',
      lecture_id = lecture_2_5_id
  WHERE task_code = 'MC2-10' AND chapter_id = chapter2_id;

  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES
    (chapter2_id, lecture_2_8_id, 'mc', 'M2-8-1', 'Chapter 2 Section 8 MC問題 1', 1, 210),
    (chapter2_id, lecture_2_8_id, 'mc', 'M2-8-2', 'Chapter 2 Section 8 MC問題 2', 1, 211),
    (chapter2_id, lecture_2_9_id, 'mc', 'M2-9-1', 'Chapter 2 Section 9 MC問題 1', 1, 212),
    (chapter2_id, lecture_2_10_id, 'mc', 'M2-10-1', 'Chapter 2 Section 10 MC問題 1', 1, 213),
    (chapter2_id, lecture_2_10_id, 'mc', 'M2-10-2', 'Chapter 2 Section 10 MC問題 2', 1, 214),
    (chapter2_id, lecture_2_11_id, 'mc', 'M2-11-01', 'Chapter 2 Section 11 MC問題 1', 1, 215),
    (chapter2_id, lecture_2_11_id, 'mc', 'M2-11-02', 'Chapter 2 Section 11 MC問題 2', 1, 216),
    (chapter2_id, lecture_2_12_id, 'mc', 'M2-12-1', 'Chapter 2 Section 12 MC問題 1', 1, 217),
    (chapter2_id, lecture_2_12_id, 'mc', 'M2-12-2', 'Chapter 2 Section 12 MC問題 2', 1, 218),
    (chapter2_id, lecture_2_12_id, 'mc', 'M2-12-3', 'Chapter 2 Section 12 MC問題 3', 1, 219);
END $$;
