/*
  # Fix Chapter 2 MC問題とレクチャーの紐付け

  1. 問題の説明
    - Chapter 2のMC問題のタスクコード（M2-X-Y）のセクション番号Xと
      実際に紐づいているlecture_numberがずれている
    - タスクコードのセクション番号 = lecture_numberとなるべき

  2. 修正内容
    - 各MC問題を正しいlecture_numberのレクチャーに再紐付け
    - 例：M2-1-1（Section 1）→ lecture_number 1のレクチャーに紐付け
*/

DO $$
DECLARE
  chapter2_id uuid;
BEGIN
  -- Chapter 2のIDを取得
  SELECT id INTO chapter2_id FROM chapters WHERE chapter_number = 2;

  -- Section 1のMC問題をlecture_number 1に紐付け
  UPDATE tasks
  SET lecture_id = (SELECT id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 1)
  WHERE chapter_id = chapter2_id 
    AND task_type = 'mc'
    AND task_code LIKE 'M2-1-%';

  -- Section 2のMC問題をlecture_number 2に紐付け
  UPDATE tasks
  SET lecture_id = (SELECT id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 2)
  WHERE chapter_id = chapter2_id 
    AND task_type = 'mc'
    AND task_code LIKE 'M2-2-%';

  -- Section 3のMC問題をlecture_number 3に紐付け
  UPDATE tasks
  SET lecture_id = (SELECT id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 3)
  WHERE chapter_id = chapter2_id 
    AND task_type = 'mc'
    AND task_code LIKE 'M2-3-%';

  -- Section 4のMC問題をlecture_number 4に紐付け
  UPDATE tasks
  SET lecture_id = (SELECT id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 4)
  WHERE chapter_id = chapter2_id 
    AND task_type = 'mc'
    AND task_code LIKE 'M2-4-%';

  -- Section 5のMC問題をlecture_number 5に紐付け
  UPDATE tasks
  SET lecture_id = (SELECT id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 5)
  WHERE chapter_id = chapter2_id 
    AND task_type = 'mc'
    AND task_code LIKE 'M2-5-%';

  -- Section 6のMC問題をlecture_number 6に紐付け
  UPDATE tasks
  SET lecture_id = (SELECT id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 6)
  WHERE chapter_id = chapter2_id 
    AND task_type = 'mc'
    AND task_code LIKE 'M2-6-%';

  -- Section 7のMC問題をlecture_number 7に紐付け
  UPDATE tasks
  SET lecture_id = (SELECT id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 7)
  WHERE chapter_id = chapter2_id 
    AND task_type = 'mc'
    AND task_code LIKE 'M2-7-%';

  -- Section 8のMC問題をlecture_number 8に紐付け
  UPDATE tasks
  SET lecture_id = (SELECT id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 8)
  WHERE chapter_id = chapter2_id 
    AND task_type = 'mc'
    AND task_code LIKE 'M2-8-%';

  -- Section 9のMC問題をlecture_number 9に紐付け
  UPDATE tasks
  SET lecture_id = (SELECT id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 9)
  WHERE chapter_id = chapter2_id 
    AND task_type = 'mc'
    AND task_code LIKE 'M2-9-%';

  -- Section 10のMC問題をlecture_number 10に紐付け
  UPDATE tasks
  SET lecture_id = (SELECT id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 10)
  WHERE chapter_id = chapter2_id 
    AND task_type = 'mc'
    AND task_code LIKE 'M2-10-%';

  -- Section 11のMC問題をlecture_number 11に紐付け
  UPDATE tasks
  SET lecture_id = (SELECT id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 11)
  WHERE chapter_id = chapter2_id 
    AND task_type = 'mc'
    AND task_code LIKE 'M2-11-%';

  -- Section 12のMC問題をlecture_number 12に紐付け
  UPDATE tasks
  SET lecture_id = (SELECT id FROM lectures WHERE chapter_id = chapter2_id AND lecture_number = 12)
  WHERE chapter_id = chapter2_id 
    AND task_type = 'mc'
    AND task_code LIKE 'M2-12-%';

END $$;
