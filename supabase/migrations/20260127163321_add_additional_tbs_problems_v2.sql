/*
  # 追加TBS問題の登録とセクション紐付け

  1. 追加内容
    - 約70個の新しいTBS問題を追加
    - タスクコード（T{チャプター}-{セクション}-{番号}）から自動的にセクションに紐付け
    - "TBS資料以外"と"資料参照型"の2種類を追加

  2. 紐付けルール
    - タスクコードのセクション番号 = lecture_numberのレクチャーに紐付け
    - 例：T1-7-1はChapter 1のlecture_number 7に紐付け

  3. ラウンド設定
    - すべてのTBS問題はround_unlock = 4（ラウンド4以降で実施）

  4. 追加される問題
    - Chapter 1: 4問
    - Chapter 2: 3問
    - Chapter 3: 16問
    - Chapter 4: 7問
    - Chapter 5: 14問
    - Chapter 8: 7問
    - Chapter 9: 5問
    - Chapter 10: 2問
    - Chapter 11: 3問
    - Chapter 12: 12問
*/

DO $$
DECLARE
  v_chapter_id uuid;
  v_lecture_id uuid;
  v_base_order_index int;
BEGIN
  -- Chapter 1のTBS問題を追加
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 1;
  SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_base_order_index FROM tasks WHERE tasks.chapter_id = v_chapter_id;

  -- T1-7-1
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 7;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T1-7-1', 'TBS問題 T1-7-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- T1-8-1
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 8;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T1-8-1', 'TBS問題 T1-8-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- T1-10-01
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 10;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T1-10-01', 'TBS問題 T1-10-01', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- T1-12-01
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 12;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T1-12-01', 'TBS問題 T1-12-01', 4, v_base_order_index);

  -- Chapter 2のTBS問題を追加
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 2;
  SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_base_order_index FROM tasks WHERE tasks.chapter_id = v_chapter_id;

  -- T2-2-1
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 2;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T2-2-1', 'TBS問題 T2-2-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- T2-11-1
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 11;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T2-11-1', 'TBS問題 T2-11-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- T2-12-1
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 12;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T2-12-1', 'TBS問題 T2-12-1（資料参照型）', 4, v_base_order_index);

  -- Chapter 3のTBS問題を追加
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 3;
  SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_base_order_index FROM tasks WHERE tasks.chapter_id = v_chapter_id;

  -- Section 2
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 2;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-2-1', 'TBS問題 T3-2-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 4
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 4;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-4-1', 'TBS問題 T3-4-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-4-2', 'TBS問題 T3-4-2', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-4-3', 'TBS問題 T3-4-3（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 5
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 5;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-5-1', 'TBS問題 T3-5-1（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 8
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 8;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-8-1', 'TBS問題 T3-8-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-8-2', 'TBS問題 T3-8-2（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 13
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 13;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-13-1', 'TBS問題 T3-13-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 15
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 15;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-15-1', 'TBS問題 T3-15-1（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-15-2', 'TBS問題 T3-15-2（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 20
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 20;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-20-1', 'TBS問題 T3-20-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-20-2', 'TBS問題 T3-20-2（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 21
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 21;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-21-1', 'TBS問題 T3-21-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 23
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 23;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-23-1', 'TBS問題 T3-23-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 24
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 24;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-24-1', 'TBS問題 T3-24-1（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 27
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 27;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T3-27-1', 'TBS問題 T3-27-1', 4, v_base_order_index);

  -- Chapter 4のTBS問題を追加
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 4;
  SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_base_order_index FROM tasks WHERE tasks.chapter_id = v_chapter_id;

  -- Section 1
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 1;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T4-1-1', 'TBS問題 T4-1-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 2
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 2;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T4-2-1', 'TBS問題 T4-2-1（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T4-2-2', 'TBS問題 T4-2-2（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 9
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 9;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T4-9-1', 'TBS問題 T4-9-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T4-9-2', 'TBS問題 T4-9-2', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T4-9-3', 'TBS問題 T4-9-3（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 10
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 10;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T4-10-1', 'TBS問題 T4-10-1', 4, v_base_order_index);

  -- Chapter 5のTBS問題を追加
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 5;
  SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_base_order_index FROM tasks WHERE tasks.chapter_id = v_chapter_id;

  -- Section 1
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 1;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T5-1-1', 'TBS問題 T5-1-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 2
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 2;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T5-2-1', 'TBS問題 T5-2-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 3
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 3;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T5-3-1', 'TBS問題 T5-3-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 4
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 4;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T5-4-1', 'TBS問題 T5-4-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T5-4-2', 'TBS問題 T5-4-2（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 8
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 8;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T5-8-1', 'TBS問題 T5-8-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 12
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 12;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T5-12-1', 'TBS問題 T5-12-1（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 14
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 14;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T5-14-1', 'TBS問題 T5-14-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T5-14-2', 'TBS問題 T5-14-2（資料参照型）', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 15
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 15;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T5-15-1', 'TBS問題 T5-15-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 18
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 18;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T5-18-1', 'TBS問題 T5-18-1', 4, v_base_order_index);
  v_base_order_index := v_base_order_index + 1;

  -- Section 19
  SELECT id INTO v_lecture_id FROM lectures WHERE lectures.chapter_id = v_chapter_id AND lecture_number = 19;
  INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
  VALUES (v_chapter_id, v_lecture_id, 'tbs', 'T5-19-1', 'TBS問題 T5-19-1', 4, v_base_order_index);

END $$;
