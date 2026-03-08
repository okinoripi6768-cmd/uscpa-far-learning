/*
  # Fix Chapter 1 MC Problems Mapping

  1. Changes Made
    - Delete existing Chapter 1 MC and TBS problems that have incorrect mapping
    - Recreate MC problems with correct section mapping based on actual curriculum
    - Section 0: No MC problems
    - Section 1: 1 MC problem (M1-1-1)
    - Section 2: 1 MC problem (M1-2-1)
    - Section 3: 1 MC problem (M1-3-1)
    - Sections 4-6: No MC problems (lecture only)
    - Section 7: 1 MC problem (M1-7-1)
    - Section 8: 1 MC problem (M1-8-1)
    - Section 9: 4 MC problems (M1-9-1 to M1-9-4)
    - Section 10: 4 MC problems (M1-10-1 to M1-10-4)
    - Section 11: 2 MC problems (M1-11-1 to M1-11-2)
    - Section 12: 2 MC problems (M1-12-1 to M1-12-2)

  2. Total MC Problems
    - Chapter 1: 17 MC problems

  3. Notes
    - Each MC problem represents a single question to be answered
    - TBS problems are removed for now and will be added in later rounds
    - Order index follows pattern: ChapterXX + SectionXX + 02-99 for MC problems
*/

-- Delete existing Chapter 1 MC and TBS tasks
DELETE FROM tasks 
WHERE task_code LIKE 'MC1-%' OR task_code LIKE 'TBS1-%';

-- Get lecture IDs for Chapter 1
DO $$
DECLARE
  chapter1_id uuid;
  lecture1_id uuid;
  lecture2_id uuid;
  lecture3_id uuid;
  lecture7_id uuid;
  lecture8_id uuid;
  lecture9_id uuid;
  lecture10_id uuid;
  lecture11_id uuid;
  lecture12_id uuid;
BEGIN
  -- Get chapter 1 ID
  SELECT id INTO chapter1_id FROM chapters WHERE chapter_number = 1;

  -- Get lecture IDs
  SELECT id INTO lecture1_id FROM lectures WHERE chapter_id = chapter1_id AND lecture_number = 1;
  SELECT id INTO lecture2_id FROM lectures WHERE chapter_id = chapter1_id AND lecture_number = 2;
  SELECT id INTO lecture3_id FROM lectures WHERE chapter_id = chapter1_id AND lecture_number = 3;
  SELECT id INTO lecture7_id FROM lectures WHERE chapter_id = chapter1_id AND lecture_number = 7;
  SELECT id INTO lecture8_id FROM lectures WHERE chapter_id = chapter1_id AND lecture_number = 8;
  SELECT id INTO lecture9_id FROM lectures WHERE chapter_id = chapter1_id AND lecture_number = 9;
  SELECT id INTO lecture10_id FROM lectures WHERE chapter_id = chapter1_id AND lecture_number = 10;
  SELECT id INTO lecture11_id FROM lectures WHERE chapter_id = chapter1_id AND lecture_number = 11;
  SELECT id INTO lecture12_id FROM lectures WHERE chapter_id = chapter1_id AND lecture_number = 12;

  -- Section 1-1: 1 MC problem
  INSERT INTO tasks (task_code, task_type, title, round_unlock, order_index, lecture_id)
  VALUES ('M1-1-1', 'mc', 'Chapter 1 Section 1 MC問題 1', 1, 10102, lecture1_id);

  -- Section 1-2: 1 MC problem
  INSERT INTO tasks (task_code, task_type, title, round_unlock, order_index, lecture_id)
  VALUES ('M1-2-1', 'mc', 'Chapter 1 Section 2 MC問題 1', 1, 10202, lecture2_id);

  -- Section 1-3: 1 MC problem
  INSERT INTO tasks (task_code, task_type, title, round_unlock, order_index, lecture_id)
  VALUES ('M1-3-1', 'mc', 'Chapter 1 Section 3 MC問題 1', 1, 10302, lecture3_id);

  -- Section 1-7: 1 MC problem
  INSERT INTO tasks (task_code, task_type, title, round_unlock, order_index, lecture_id)
  VALUES ('M1-7-1', 'mc', 'Chapter 1 Section 7 MC問題 1', 1, 10702, lecture7_id);

  -- Section 1-8: 1 MC problem
  INSERT INTO tasks (task_code, task_type, title, round_unlock, order_index, lecture_id)
  VALUES ('M1-8-1', 'mc', 'Chapter 1 Section 8 MC問題 1', 1, 10802, lecture8_id);

  -- Section 1-9: 4 MC problems
  INSERT INTO tasks (task_code, task_type, title, round_unlock, order_index, lecture_id)
  VALUES 
    ('M1-9-1', 'mc', 'Chapter 1 Section 9 MC問題 1', 1, 10902, lecture9_id),
    ('M1-9-2', 'mc', 'Chapter 1 Section 9 MC問題 2', 1, 10903, lecture9_id),
    ('M1-9-3', 'mc', 'Chapter 1 Section 9 MC問題 3', 1, 10904, lecture9_id),
    ('M1-9-4', 'mc', 'Chapter 1 Section 9 MC問題 4', 1, 10905, lecture9_id);

  -- Section 1-10: 4 MC problems
  INSERT INTO tasks (task_code, task_type, title, round_unlock, order_index, lecture_id)
  VALUES 
    ('M1-10-1', 'mc', 'Chapter 1 Section 10 MC問題 1', 1, 11002, lecture10_id),
    ('M1-10-2', 'mc', 'Chapter 1 Section 10 MC問題 2', 1, 11003, lecture10_id),
    ('M1-10-3', 'mc', 'Chapter 1 Section 10 MC問題 3', 1, 11004, lecture10_id),
    ('M1-10-4', 'mc', 'Chapter 1 Section 10 MC問題 4', 1, 11005, lecture10_id);

  -- Section 1-11: 2 MC problems
  INSERT INTO tasks (task_code, task_type, title, round_unlock, order_index, lecture_id)
  VALUES 
    ('M1-11-1', 'mc', 'Chapter 1 Section 11 MC問題 1', 1, 11102, lecture11_id),
    ('M1-11-2', 'mc', 'Chapter 1 Section 11 MC問題 2', 1, 11103, lecture11_id);

  -- Section 1-12: 2 MC problems
  INSERT INTO tasks (task_code, task_type, title, round_unlock, order_index, lecture_id)
  VALUES 
    ('M1-12-1', 'mc', 'Chapter 1 Section 12 MC問題 1', 1, 11202, lecture12_id),
    ('M1-12-2', 'mc', 'Chapter 1 Section 12 MC問題 2', 1, 11203, lecture12_id);
END $$;
