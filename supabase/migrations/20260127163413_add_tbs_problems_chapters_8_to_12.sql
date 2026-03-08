/*
  # TBS問題の追加（Chapter 8-12）

  1. 追加内容
    - Chapter 8: 7問
    - Chapter 9: 5問
    - Chapter 10: 2問
    - Chapter 11: 3問
    - Chapter 12: 12問

  2. 紐付けルール
    - タスクコードのセクション番号に対応するレクチャーに紐付け

  3. ラウンド設定
    - すべてround_unlock = 4
*/

DO $$
DECLARE
  v_chapter_id uuid;
  v_lecture_id uuid;
  v_base_order_index int;
BEGIN
  -- Chapter 8のTBS問題を追加
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 8;
  
  IF v_chapter_id IS NOT NULL THEN
    SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_base_order_index FROM tasks WHERE tasks.chapter_id = v_chapter_id;

    -- Section 1
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 1;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T8-1-1', 'TBS問題 T8-1-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 6
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 6;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T8-6-1', 'TBS問題 T8-6-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 7
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 7;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T8-7-1', 'TBS問題 T8-7-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 9
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 9;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T8-9-1', 'TBS問題 T8-9-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 10
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 10;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T8-10-1', 'TBS問題 T8-10-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 11
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 11;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T8-11-1', 'TBS問題 T8-11-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 15
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 15;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T8-15-1', 'TBS問題 T8-15-1', 4, v_base_order_index);
    END IF;
  END IF;

  -- Chapter 9のTBS問題を追加
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 9;
  
  IF v_chapter_id IS NOT NULL THEN
    SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_base_order_index FROM tasks WHERE tasks.chapter_id = v_chapter_id;

    -- Section 4
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 4;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T9-4-1', 'TBS問題 T9-4-1（資料参照型）', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 6
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 6;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T9-6-1', 'TBS問題 T9-6-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 7
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 7;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T9-7-1', 'TBS問題 T9-7-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;

      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T9-7-2', 'TBS問題 T9-7-2', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;

      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T9-7-3', 'TBS問題 T9-7-3', 4, v_base_order_index);
    END IF;
  END IF;

  -- Chapter 10のTBS問題を追加
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 10;
  
  IF v_chapter_id IS NOT NULL THEN
    SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_base_order_index FROM tasks WHERE tasks.chapter_id = v_chapter_id;

    -- Section 6
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 6;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T10-6-1', 'TBS問題 T10-6-1（資料参照型）', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;

      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T10-6-2', 'TBS問題 T10-6-2', 4, v_base_order_index);
    END IF;
  END IF;

  -- Chapter 11のTBS問題を追加
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 11;
  
  IF v_chapter_id IS NOT NULL THEN
    SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_base_order_index FROM tasks WHERE tasks.chapter_id = v_chapter_id;

    -- Section 2
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 2;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T11-2-1', 'TBS問題 T11-2-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 5
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 5;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T11-5-1', 'TBS問題 T11-5-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 11
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 11;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T11-11-1', 'TBS問題 T11-11-1', 4, v_base_order_index);
    END IF;
  END IF;

  -- Chapter 12のTBS問題を追加
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 12;
  
  IF v_chapter_id IS NOT NULL THEN
    SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_base_order_index FROM tasks WHERE tasks.chapter_id = v_chapter_id;

    -- Section 3
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 3;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T12-3-1', 'TBS問題 T12-3-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 6
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 6;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T12-6-1', 'TBS問題 T12-6-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 7
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 7;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T12-7-1', 'TBS問題 T12-7-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 8
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 8;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T12-8-1', 'TBS問題 T12-8-1（資料参照型）', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 9
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 9;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T12-9-1', 'TBS問題 T12-9-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 16
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 16;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T12-16-1', 'TBS問題 T12-16-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 20
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 20;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T12-20-1', 'TBS問題 T12-20-1（資料参照型）', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 23
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 23;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T12-23-1', 'TBS問題 T12-23-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 25
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 25;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T12-25-1', 'TBS問題 T12-25-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 26
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 26;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T12-26-1', 'TBS問題 T12-26-1（資料参照型）', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;
    END IF;

    -- Section 29
    SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 29;
    IF v_lecture_id IS NOT NULL THEN
      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T12-29-1', 'TBS問題 T12-29-1', 4, v_base_order_index);
      v_base_order_index := v_base_order_index + 1;

      INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
      VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T12-29-2', 'TBS問題 T12-29-2', 4, v_base_order_index);
    END IF;
  END IF;

END $$;
