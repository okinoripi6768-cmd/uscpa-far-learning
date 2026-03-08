/*
  # Add Chapters 13-21 with Tasks (Continuation)

  1. Chapters 13-21
    - Chapter 13: Investments
    - Chapter 14: Consolidated Financial Statements
    - Chapter 15: Deferred Taxes
    - Chapter 16: Statement of Cash Flows
    - Chapter 17: Accounting Changes and Error Corrections
    - Chapter 18: Miscellaneous Topics
    - Chapter 19: Financial Statement Ratios
    - Chapter 20: Nongovernmental Not-for-profit Organizations
    - Chapter 21: Governmental Accounting
*/

-- Chapter 13: Investments
DO $$
DECLARE
  chapter13_id uuid;
BEGIN
  INSERT INTO chapters (chapter_number, title, lecture_duration_minutes, order_index)
  VALUES (13, 'Chapter 13: Investments', 396, 13)
  RETURNING id INTO chapter13_id;

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index)
  VALUES (chapter13_id, 'lecture', 'Watch Chapter 13 Lecture', 'L13', 1, 1);

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index) VALUES
  (chapter13_id, 'mc', 'MC Question M13-01-01', 'M13-01-01', 2, 2),
  (chapter13_id, 'mc', 'MC Question M13-01-02', 'M13-01-02', 2, 3),
  (chapter13_id, 'mc', 'MC Question M13-02-01', 'M13-02-01', 2, 4),
  (chapter13_id, 'mc', 'MC Question M13-02-02', 'M13-02-02', 2, 5),
  (chapter13_id, 'mc', 'MC Question M13-02-03', 'M13-02-03', 2, 6),
  (chapter13_id, 'mc', 'MC Question M13-02-04', 'M13-02-04', 2, 7),
  (chapter13_id, 'mc', 'MC Question M13-02-05', 'M13-02-05', 2, 8),
  (chapter13_id, 'mc', 'MC Question M13-02-06', 'M13-02-06', 2, 9),
  (chapter13_id, 'mc', 'MC Question M13-03-01', 'M13-03-01', 2, 10),
  (chapter13_id, 'mc', 'MC Question M13-03-02', 'M13-03-02', 2, 11),
  (chapter13_id, 'mc', 'MC Question M13-03-03', 'M13-03-03', 2, 12),
  (chapter13_id, 'mc', 'MC Question M13-04-01', 'M13-04-01', 2, 13),
  (chapter13_id, 'mc', 'MC Question M13-04-02', 'M13-04-02', 2, 14),
  (chapter13_id, 'mc', 'MC Question M13-04-03', 'M13-04-03', 2, 15),
  (chapter13_id, 'mc', 'MC Question M13-04-04', 'M13-04-04', 2, 16),
  (chapter13_id, 'mc', 'MC Question M13-04-05', 'M13-04-05', 2, 17),
  (chapter13_id, 'mc', 'MC Question M13-05-01', 'M13-05-01', 2, 18),
  (chapter13_id, 'mc', 'MC Question M13-05-02', 'M13-05-02', 2, 19),
  (chapter13_id, 'mc', 'MC Question M13-05-03', 'M13-05-03', 2, 20),
  (chapter13_id, 'mc', 'MC Question M13-05-04', 'M13-05-04', 2, 21),
  (chapter13_id, 'mc', 'MC Question M13-05-05', 'M13-05-05', 2, 22),
  (chapter13_id, 'mc', 'MC Question M13-05-06', 'M13-05-06', 2, 23),
  (chapter13_id, 'mc', 'MC Question M13-06-01', 'M13-06-01', 2, 24),
  (chapter13_id, 'mc', 'MC Question M13-06-02', 'M13-06-02', 2, 25),
  (chapter13_id, 'mc', 'MC Question M13-06-03', 'M13-06-03', 2, 26),
  (chapter13_id, 'mc', 'MC Question M13-07-01', 'M13-07-01', 2, 27),
  (chapter13_id, 'mc', 'MC Question M13-07-02', 'M13-07-02', 2, 28),
  (chapter13_id, 'mc', 'MC Question M13-07-03', 'M13-07-03', 2, 29),
  (chapter13_id, 'mc', 'MC Question M13-07-04', 'M13-07-04', 2, 30),
  (chapter13_id, 'mc', 'MC Question M13-08-01', 'M13-08-01', 2, 31),
  (chapter13_id, 'mc', 'MC Question M13-08-02', 'M13-08-02', 2, 32),
  (chapter13_id, 'mc', 'MC Question M13-08-03', 'M13-08-03', 2, 33),
  (chapter13_id, 'mc', 'MC Question M13-09-01', 'M13-09-01', 2, 34),
  (chapter13_id, 'mc', 'MC Question M13-10-01', 'M13-10-01', 2, 35),
  (chapter13_id, 'mc', 'MC Question M13-11-01', 'M13-11-01', 2, 36),
  (chapter13_id, 'mc', 'MC Question M13-11-02', 'M13-11-02', 2, 37),
  (chapter13_id, 'mc', 'MC Question M13-11-03', 'M13-11-03', 2, 38),
  (chapter13_id, 'mc', 'MC Question M13-11-04', 'M13-11-04', 2, 39),
  (chapter13_id, 'mc', 'MC Question M13-11-05', 'M13-11-05', 2, 40),
  (chapter13_id, 'mc', 'MC Question M13-11-06', 'M13-11-06', 2, 41),
  (chapter13_id, 'mc', 'MC Question M13-12-01', 'M13-12-01', 2, 42),
  (chapter13_id, 'mc', 'MC Question M13-13-01', 'M13-13-01', 2, 43),
  (chapter13_id, 'mc', 'MC Question M13-13-02', 'M13-13-02', 2, 44);
END $$;

-- Chapter 14: Consolidated Financial Statements
DO $$
DECLARE
  chapter14_id uuid;
BEGIN
  INSERT INTO chapters (chapter_number, title, lecture_duration_minutes, order_index)
  VALUES (14, 'Chapter 14: Consolidated Financial Statements', 246, 14)
  RETURNING id INTO chapter14_id;

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index)
  VALUES (chapter14_id, 'lecture', 'Watch Chapter 14 Lecture', 'L14', 1, 1);

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index) VALUES
  (chapter14_id, 'mc', 'MC Question M14-01-01', 'M14-01-01', 2, 2),
  (chapter14_id, 'mc', 'MC Question M14-01-02', 'M14-01-02', 2, 3),
  (chapter14_id, 'mc', 'MC Question M14-01-03', 'M14-01-03', 2, 4),
  (chapter14_id, 'mc', 'MC Question M14-03-01', 'M14-03-01', 2, 5),
  (chapter14_id, 'mc', 'MC Question M14-04-01', 'M14-04-01', 2, 6),
  (chapter14_id, 'mc', 'MC Question M14-05-01', 'M14-05-01', 2, 7),
  (chapter14_id, 'mc', 'MC Question M14-07-01', 'M14-07-01', 2, 8),
  (chapter14_id, 'mc', 'MC Question M14-07-02', 'M14-07-02', 2, 9),
  (chapter14_id, 'mc', 'MC Question M14-07-03', 'M14-07-03', 2, 10),
  (chapter14_id, 'mc', 'MC Question M14-08-01', 'M14-08-01', 2, 11),
  (chapter14_id, 'mc', 'MC Question M14-08-02', 'M14-08-02', 2, 12),
  (chapter14_id, 'mc', 'MC Question M14-09-01', 'M14-09-01', 2, 13),
  (chapter14_id, 'mc', 'MC Question M14-09-02', 'M14-09-02', 2, 14),
  (chapter14_id, 'mc', 'MC Question M14-09-03', 'M14-09-03', 2, 15),
  (chapter14_id, 'mc', 'MC Question M14-09-04', 'M14-09-04', 2, 16),
  (chapter14_id, 'mc', 'MC Question M14-09-05', 'M14-09-05', 2, 17),
  (chapter14_id, 'mc', 'MC Question M14-09-06', 'M14-09-06', 2, 18),
  (chapter14_id, 'mc', 'MC Question M14-10-01', 'M14-10-01', 2, 19),
  (chapter14_id, 'mc', 'MC Question M14-10-02', 'M14-10-02', 2, 20),
  (chapter14_id, 'mc', 'MC Question M14-10-03', 'M14-10-03', 2, 21),
  (chapter14_id, 'mc', 'MC Question M14-11-01', 'M14-11-01', 2, 22),
  (chapter14_id, 'mc', 'MC Question M14-11-02', 'M14-11-02', 2, 23),
  (chapter14_id, 'mc', 'MC Question M14-12-01', 'M14-12-01', 2, 24),
  (chapter14_id, 'mc', 'MC Question M14-12-02', 'M14-12-02', 2, 25);
END $$;

-- Chapter 15: Deferred Taxes
DO $$
DECLARE
  chapter15_id uuid;
BEGIN
  INSERT INTO chapters (chapter_number, title, lecture_duration_minutes, order_index)
  VALUES (15, 'Chapter 15: Deferred Taxes', 348, 15)
  RETURNING id INTO chapter15_id;

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index)
  VALUES (chapter15_id, 'lecture', 'Watch Chapter 15 Lecture', 'L15', 1, 1);

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index) VALUES
  (chapter15_id, 'mc', 'MC Question M15-03-01', 'M15-03-01', 2, 2),
  (chapter15_id, 'mc', 'MC Question M15-03-02', 'M15-03-02', 2, 3),
  (chapter15_id, 'mc', 'MC Question M15-04-01', 'M15-04-01', 2, 4),
  (chapter15_id, 'mc', 'MC Question M15-04-02', 'M15-04-02', 2, 5),
  (chapter15_id, 'mc', 'MC Question M15-05-01', 'M15-05-01', 2, 6),
  (chapter15_id, 'mc', 'MC Question M15-06-01', 'M15-06-01', 2, 7),
  (chapter15_id, 'mc', 'MC Question M15-07-01', 'M15-07-01', 2, 8),
  (chapter15_id, 'mc', 'MC Question M15-07-02', 'M15-07-02', 2, 9),
  (chapter15_id, 'mc', 'MC Question M15-08-01', 'M15-08-01', 2, 10),
  (chapter15_id, 'mc', 'MC Question M15-10-01', 'M15-10-01', 2, 11),
  (chapter15_id, 'mc', 'MC Question M15-10-02', 'M15-10-02', 2, 12),
  (chapter15_id, 'mc', 'MC Question M15-13-01', 'M15-13-01', 2, 13),
  (chapter15_id, 'mc', 'MC Question M15-13-02', 'M15-13-02', 2, 14),
  (chapter15_id, 'mc', 'MC Question M15-13-03', 'M15-13-03', 2, 15),
  (chapter15_id, 'mc', 'MC Question M15-13-04', 'M15-13-04', 2, 16),
  (chapter15_id, 'mc', 'MC Question M15-13-05', 'M15-13-05', 2, 17),
  (chapter15_id, 'mc', 'MC Question M15-14-01', 'M15-14-01', 2, 18),
  (chapter15_id, 'mc', 'MC Question M15-15-01', 'M15-15-01', 2, 19),
  (chapter15_id, 'mc', 'MC Question M15-15-02', 'M15-15-02', 2, 20),
  (chapter15_id, 'mc', 'MC Question M15-15-03', 'M15-15-03', 2, 21),
  (chapter15_id, 'mc', 'MC Question M15-15-04', 'M15-15-04', 2, 22),
  (chapter15_id, 'mc', 'MC Question M15-16-01', 'M15-16-01', 2, 23),
  (chapter15_id, 'mc', 'MC Question M15-16-02', 'M15-16-02', 2, 24),
  (chapter15_id, 'mc', 'MC Question M15-17-01', 'M15-17-01', 2, 25),
  (chapter15_id, 'mc', 'MC Question M15-18-01', 'M15-18-01', 2, 26),
  (chapter15_id, 'mc', 'MC Question M15-19-01', 'M15-19-01', 2, 27),
  (chapter15_id, 'mc', 'MC Question M15-19-02', 'M15-19-02', 2, 28),
  (chapter15_id, 'mc', 'MC Question M15-19-03', 'M15-19-03', 2, 29),
  (chapter15_id, 'mc', 'MC Question M15-19-04', 'M15-19-04', 2, 30),
  (chapter15_id, 'mc', 'MC Question M15-19-05', 'M15-19-05', 2, 31),
  (chapter15_id, 'mc', 'MC Question M15-20-01', 'M15-20-01', 2, 32),
  (chapter15_id, 'mc', 'MC Question M15-20-02', 'M15-20-02', 2, 33),
  (chapter15_id, 'mc', 'MC Question M15-21-01', 'M15-21-01', 2, 34);
END $$;

-- Chapter 16: Statement of Cash Flows
DO $$
DECLARE
  chapter16_id uuid;
BEGIN
  INSERT INTO chapters (chapter_number, title, lecture_duration_minutes, order_index)
  VALUES (16, 'Chapter 16: Statement of Cash Flows', 270, 16)
  RETURNING id INTO chapter16_id;

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index)
  VALUES (chapter16_id, 'lecture', 'Watch Chapter 16 Lecture', 'L16', 1, 1);

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index) VALUES
  (chapter16_id, 'mc', 'MC Question M16-01-01', 'M16-01-01', 2, 2),
  (chapter16_id, 'mc', 'MC Question M16-02-01', 'M16-02-01', 2, 3),
  (chapter16_id, 'mc', 'MC Question M16-02-02', 'M16-02-02', 2, 4),
  (chapter16_id, 'mc', 'MC Question M16-02-03', 'M16-02-03', 2, 5),
  (chapter16_id, 'mc', 'MC Question M16-05-01', 'M16-05-01', 2, 6),
  (chapter16_id, 'mc', 'MC Question M16-05-02', 'M16-05-02', 2, 7),
  (chapter16_id, 'mc', 'MC Question M16-05-03', 'M16-05-03', 2, 8),
  (chapter16_id, 'mc', 'MC Question M16-06-01', 'M16-06-01', 2, 9),
  (chapter16_id, 'mc', 'MC Question M16-06-02', 'M16-06-02', 2, 10),
  (chapter16_id, 'mc', 'MC Question M16-06-03', 'M16-06-03', 2, 11),
  (chapter16_id, 'mc', 'MC Question M16-06-04', 'M16-06-04', 2, 12),
  (chapter16_id, 'mc', 'MC Question M16-06-05', 'M16-06-05', 2, 13),
  (chapter16_id, 'mc', 'MC Question M16-06-06', 'M16-06-06', 2, 14),
  (chapter16_id, 'mc', 'MC Question M16-06-07', 'M16-06-07', 2, 15),
  (chapter16_id, 'mc', 'MC Question M16-06-08', 'M16-06-08', 2, 16),
  (chapter16_id, 'mc', 'MC Question M16-07-01', 'M16-07-01', 2, 17),
  (chapter16_id, 'mc', 'MC Question M16-07-02', 'M16-07-02', 2, 18),
  (chapter16_id, 'mc', 'MC Question M16-07-03', 'M16-07-03', 2, 19),
  (chapter16_id, 'mc', 'MC Question M16-07-04', 'M16-07-04', 2, 20),
  (chapter16_id, 'mc', 'MC Question M16-07-05', 'M16-07-05', 2, 21),
  (chapter16_id, 'mc', 'MC Question M16-08-01', 'M16-08-01', 2, 22),
  (chapter16_id, 'mc', 'MC Question M16-08-02', 'M16-08-02', 2, 23),
  (chapter16_id, 'mc', 'MC Question M16-08-03', 'M16-08-03', 2, 24),
  (chapter16_id, 'mc', 'MC Question M16-08-04', 'M16-08-04', 2, 25),
  (chapter16_id, 'mc', 'MC Question M16-09-01', 'M16-09-01', 2, 26),
  (chapter16_id, 'mc', 'MC Question M16-09-02', 'M16-09-02', 2, 27),
  (chapter16_id, 'mc', 'MC Question M16-10-01', 'M16-10-01', 2, 28),
  (chapter16_id, 'mc', 'MC Question M16-10-02', 'M16-10-02', 2, 29),
  (chapter16_id, 'mc', 'MC Question M16-10-03', 'M16-10-03', 2, 30),
  (chapter16_id, 'mc', 'MC Question M16-10-04', 'M16-10-04', 2, 31),
  (chapter16_id, 'mc', 'MC Question M16-11-01', 'M16-11-01', 2, 32),
  (chapter16_id, 'mc', 'MC Question M16-11-02', 'M16-11-02', 2, 33),
  (chapter16_id, 'mc', 'MC Question M16-12-01', 'M16-12-01', 2, 34),
  (chapter16_id, 'mc', 'MC Question M16-12-02', 'M16-12-02', 2, 35);
END $$;

-- Chapter 17: Accounting Changes and Error Corrections
DO $$
DECLARE
  chapter17_id uuid;
BEGIN
  INSERT INTO chapters (chapter_number, title, lecture_duration_minutes, order_index)
  VALUES (17, 'Chapter 17: Accounting Changes and Error Corrections', 174, 17)
  RETURNING id INTO chapter17_id;

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index)
  VALUES (chapter17_id, 'lecture', 'Watch Chapter 17 Lecture', 'L17', 1, 1);

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index) VALUES
  (chapter17_id, 'mc', 'MC Question M17-01-01', 'M17-01-01', 2, 2),
  (chapter17_id, 'mc', 'MC Question M17-01-02', 'M17-01-02', 2, 3),
  (chapter17_id, 'mc', 'MC Question M17-01-03', 'M17-01-03', 2, 4),
  (chapter17_id, 'mc', 'MC Question M17-01-04', 'M17-01-04', 2, 5),
  (chapter17_id, 'mc', 'MC Question M17-01-05', 'M17-01-05', 2, 6),
  (chapter17_id, 'mc', 'MC Question M17-02-01', 'M17-02-01', 2, 7),
  (chapter17_id, 'mc', 'MC Question M17-02-02', 'M17-02-02', 2, 8),
  (chapter17_id, 'mc', 'MC Question M17-02-03', 'M17-02-03', 2, 9),
  (chapter17_id, 'mc', 'MC Question M17-02-04', 'M17-02-04', 2, 10),
  (chapter17_id, 'mc', 'MC Question M17-02-05', 'M17-02-05', 2, 11),
  (chapter17_id, 'mc', 'MC Question M17-03-01', 'M17-03-01', 2, 12),
  (chapter17_id, 'mc', 'MC Question M17-03-02', 'M17-03-02', 2, 13),
  (chapter17_id, 'mc', 'MC Question M17-04-01', 'M17-04-01', 2, 14),
  (chapter17_id, 'mc', 'MC Question M17-04-02', 'M17-04-02', 2, 15),
  (chapter17_id, 'mc', 'MC Question M17-05-01', 'M17-05-01', 2, 16),
  (chapter17_id, 'mc', 'MC Question M17-05-02', 'M17-05-02', 2, 17),
  (chapter17_id, 'mc', 'MC Question M17-05-03', 'M17-05-03', 2, 18),
  (chapter17_id, 'mc', 'MC Question M17-05-04', 'M17-05-04', 2, 19),
  (chapter17_id, 'mc', 'MC Question M17-06-01', 'M17-06-01', 2, 20),
  (chapter17_id, 'mc', 'MC Question M17-06-02', 'M17-06-02', 2, 21);
END $$;

-- Chapter 18: Miscellaneous Topics
DO $$
DECLARE
  chapter18_id uuid;
BEGIN
  INSERT INTO chapters (chapter_number, title, lecture_duration_minutes, order_index)
  VALUES (18, 'Chapter 18: Miscellaneous Topics', 96, 18)
  RETURNING id INTO chapter18_id;

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index)
  VALUES (chapter18_id, 'lecture', 'Watch Chapter 18 Lecture', 'L18', 1, 1);

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index) VALUES
  (chapter18_id, 'mc', 'MC Question M18-01-01', 'M18-01-01', 2, 2),
  (chapter18_id, 'mc', 'MC Question M18-01-02', 'M18-01-02', 2, 3),
  (chapter18_id, 'mc', 'MC Question M18-01-03', 'M18-01-03', 2, 4),
  (chapter18_id, 'mc', 'MC Question M18-02-01', 'M18-02-01', 2, 5),
  (chapter18_id, 'mc', 'MC Question M18-02-02', 'M18-02-02', 2, 6),
  (chapter18_id, 'mc', 'MC Question M18-02-03', 'M18-02-03', 2, 7),
  (chapter18_id, 'mc', 'MC Question M18-02-04', 'M18-02-04', 2, 8),
  (chapter18_id, 'mc', 'MC Question M18-02-05', 'M18-02-05', 2, 9),
  (chapter18_id, 'mc', 'MC Question M18-02-06', 'M18-02-06', 2, 10),
  (chapter18_id, 'mc', 'MC Question M18-02-07', 'M18-02-07', 2, 11),
  (chapter18_id, 'mc', 'MC Question M18-02-08', 'M18-02-08', 2, 12),
  (chapter18_id, 'mc', 'MC Question M18-02-09', 'M18-02-09', 2, 13),
  (chapter18_id, 'mc', 'MC Question M18-03-01', 'M18-03-01', 2, 14),
  (chapter18_id, 'mc', 'MC Question M18-04-01', 'M18-04-01', 2, 15),
  (chapter18_id, 'mc', 'MC Question M18-04-02', 'M18-04-02', 2, 16),
  (chapter18_id, 'mc', 'MC Question M18-04-03', 'M18-04-03', 2, 17),
  (chapter18_id, 'mc', 'MC Question M18-04-04', 'M18-04-04', 2, 18),
  (chapter18_id, 'mc', 'MC Question M18-04-05', 'M18-04-05', 2, 19);
END $$;

-- Chapter 19: Financial Statement Ratios and Performance Metrics
DO $$
DECLARE
  chapter19_id uuid;
BEGIN
  INSERT INTO chapters (chapter_number, title, lecture_duration_minutes, order_index)
  VALUES (19, 'Chapter 19: Financial Statement Ratios and Performance Metrics', 372, 19)
  RETURNING id INTO chapter19_id;

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index)
  VALUES (chapter19_id, 'lecture', 'Watch Chapter 19 Lecture', 'L19', 1, 1);

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index) VALUES
  (chapter19_id, 'mc', 'MC Question M19-01-01', 'M19-01-01', 2, 2),
  (chapter19_id, 'mc', 'MC Question M19-02-01', 'M19-02-01', 2, 3),
  (chapter19_id, 'mc', 'MC Question M19-03-01', 'M19-03-01', 2, 4),
  (chapter19_id, 'mc', 'MC Question M19-03-02', 'M19-03-02', 2, 5),
  (chapter19_id, 'mc', 'MC Question M19-03-03', 'M19-03-03', 2, 6),
  (chapter19_id, 'mc', 'MC Question M19-03-04', 'M19-03-04', 2, 7),
  (chapter19_id, 'mc', 'MC Question M19-04-01', 'M19-04-01', 2, 8),
  (chapter19_id, 'mc', 'MC Question M19-04-02', 'M19-04-02', 2, 9),
  (chapter19_id, 'mc', 'MC Question M19-05-01', 'M19-05-01', 2, 10),
  (chapter19_id, 'mc', 'MC Question M19-05-02', 'M19-05-02', 2, 11),
  (chapter19_id, 'mc', 'MC Question M19-05-03', 'M19-05-03', 2, 12),
  (chapter19_id, 'mc', 'MC Question M19-05-04', 'M19-05-04', 2, 13),
  (chapter19_id, 'mc', 'MC Question M19-05-05', 'M19-05-05', 2, 14),
  (chapter19_id, 'mc', 'MC Question M19-05-06', 'M19-05-06', 2, 15),
  (chapter19_id, 'mc', 'MC Question M19-06-01', 'M19-06-01', 2, 16),
  (chapter19_id, 'mc', 'MC Question M19-06-02', 'M19-06-02', 2, 17),
  (chapter19_id, 'mc', 'MC Question M19-07-01', 'M19-07-01', 2, 18),
  (chapter19_id, 'mc', 'MC Question M19-07-02', 'M19-07-02', 2, 19),
  (chapter19_id, 'mc', 'MC Question M19-07-03', 'M19-07-03', 2, 20),
  (chapter19_id, 'mc', 'MC Question M19-07-04', 'M19-07-04', 2, 21),
  (chapter19_id, 'mc', 'MC Question M19-07-05', 'M19-07-05', 2, 22),
  (chapter19_id, 'mc', 'MC Question M19-08-01', 'M19-08-01', 2, 23),
  (chapter19_id, 'mc', 'MC Question M19-09-01', 'M19-09-01', 2, 24),
  (chapter19_id, 'mc', 'MC Question M19-10-01', 'M19-10-01', 2, 25),
  (chapter19_id, 'mc', 'MC Question M19-10-02', 'M19-10-02', 2, 26),
  (chapter19_id, 'mc', 'MC Question M19-10-03', 'M19-10-03', 2, 27),
  (chapter19_id, 'mc', 'MC Question M19-10-04', 'M19-10-04', 2, 28),
  (chapter19_id, 'mc', 'MC Question M19-10-05', 'M19-10-05', 2, 29),
  (chapter19_id, 'mc', 'MC Question M19-10-06', 'M19-10-06', 2, 30),
  (chapter19_id, 'mc', 'MC Question M19-10-07', 'M19-10-07', 2, 31),
  (chapter19_id, 'mc', 'MC Question M19-10-08', 'M19-10-08', 2, 32),
  (chapter19_id, 'mc', 'MC Question M19-10-09', 'M19-10-09', 2, 33),
  (chapter19_id, 'mc', 'MC Question M19-10-10', 'M19-10-10', 2, 34),
  (chapter19_id, 'mc', 'MC Question M19-10-11', 'M19-10-11', 2, 35),
  (chapter19_id, 'mc', 'MC Question M19-10-12', 'M19-10-12', 2, 36),
  (chapter19_id, 'mc', 'MC Question M19-10-13', 'M19-10-13', 2, 37),
  (chapter19_id, 'mc', 'MC Question M19-10-14', 'M19-10-14', 2, 38),
  (chapter19_id, 'mc', 'MC Question M19-10-15', 'M19-10-15', 2, 39),
  (chapter19_id, 'mc', 'MC Question M19-10-16', 'M19-10-16', 2, 40),
  (chapter19_id, 'mc', 'MC Question M19-11-01', 'M19-11-01', 2, 41),
  (chapter19_id, 'mc', 'MC Question M19-11-02', 'M19-11-02', 2, 42),
  (chapter19_id, 'mc', 'MC Question M19-11-03', 'M19-11-03', 2, 43),
  (chapter19_id, 'mc', 'MC Question M19-12-01', 'M19-12-01', 2, 44),
  (chapter19_id, 'mc', 'MC Question M19-13-01', 'M19-13-01', 2, 45),
  (chapter19_id, 'mc', 'MC Question M19-13-02', 'M19-13-02', 2, 46),
  (chapter19_id, 'mc', 'MC Question M19-13-03', 'M19-13-03', 2, 47),
  (chapter19_id, 'mc', 'MC Question M19-14-01', 'M19-14-01', 2, 48),
  (chapter19_id, 'mc', 'MC Question M19-14-02', 'M19-14-02', 2, 49);
END $$;

-- Chapter 20: Nongovernmental Not-for-profit Organizations
DO $$
DECLARE
  chapter20_id uuid;
BEGIN
  INSERT INTO chapters (chapter_number, title, lecture_duration_minutes, order_index)
  VALUES (20, 'Chapter 20: Nongovernmental Not-for-profit Organizations', 432, 20)
  RETURNING id INTO chapter20_id;

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index)
  VALUES (chapter20_id, 'lecture', 'Watch Chapter 20 Lecture', 'L20', 1, 1);

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index) VALUES
  (chapter20_id, 'mc', 'MC Question M20-02-01', 'M20-02-01', 2, 2),
  (chapter20_id, 'mc', 'MC Question M20-02-02', 'M20-02-02', 2, 3),
  (chapter20_id, 'mc', 'MC Question M20-03-01', 'M20-03-01', 2, 4),
  (chapter20_id, 'mc', 'MC Question M20-03-02', 'M20-03-02', 2, 5),
  (chapter20_id, 'mc', 'MC Question M20-03-03', 'M20-03-03', 2, 6),
  (chapter20_id, 'mc', 'MC Question M20-03-04', 'M20-03-04', 2, 7),
  (chapter20_id, 'mc', 'MC Question M20-03-05', 'M20-03-05', 2, 8),
  (chapter20_id, 'mc', 'MC Question M20-03-06', 'M20-03-06', 2, 9),
  (chapter20_id, 'mc', 'MC Question M20-05-01', 'M20-05-01', 2, 10),
  (chapter20_id, 'mc', 'MC Question M20-05-02', 'M20-05-02', 2, 11),
  (chapter20_id, 'mc', 'MC Question M20-05-03', 'M20-05-03', 2, 12),
  (chapter20_id, 'mc', 'MC Question M20-05-04', 'M20-05-04', 2, 13),
  (chapter20_id, 'mc', 'MC Question M20-05-05', 'M20-05-05', 2, 14),
  (chapter20_id, 'mc', 'MC Question M20-05-06', 'M20-05-06', 2, 15),
  (chapter20_id, 'mc', 'MC Question M20-05-07', 'M20-05-07', 2, 16),
  (chapter20_id, 'mc', 'MC Question M20-05-08', 'M20-05-08', 2, 17),
  (chapter20_id, 'mc', 'MC Question M20-06-01', 'M20-06-01', 2, 18),
  (chapter20_id, 'mc', 'MC Question M20-06-02', 'M20-06-02', 2, 19),
  (chapter20_id, 'mc', 'MC Question M20-06-03', 'M20-06-03', 2, 20),
  (chapter20_id, 'mc', 'MC Question M20-06-04', 'M20-06-04', 2, 21),
  (chapter20_id, 'mc', 'MC Question M20-07-01', 'M20-07-01', 2, 22),
  (chapter20_id, 'mc', 'MC Question M20-07-02', 'M20-07-02', 2, 23),
  (chapter20_id, 'mc', 'MC Question M20-07-03', 'M20-07-03', 2, 24),
  (chapter20_id, 'mc', 'MC Question M20-07-04', 'M20-07-04', 2, 25),
  (chapter20_id, 'mc', 'MC Question M20-08-01', 'M20-08-01', 2, 26),
  (chapter20_id, 'mc', 'MC Question M20-09-01', 'M20-09-01', 2, 27),
  (chapter20_id, 'mc', 'MC Question M20-09-02', 'M20-09-02', 2, 28),
  (chapter20_id, 'mc', 'MC Question M20-10-01', 'M20-10-01', 2, 29),
  (chapter20_id, 'mc', 'MC Question M20-11-01', 'M20-11-01', 2, 30),
  (chapter20_id, 'mc', 'MC Question M20-11-02', 'M20-11-02', 2, 31),
  (chapter20_id, 'mc', 'MC Question M20-11-03', 'M20-11-03', 2, 32),
  (chapter20_id, 'mc', 'MC Question M20-11-04', 'M20-11-04', 2, 33),
  (chapter20_id, 'mc', 'MC Question M20-12-01', 'M20-12-01', 2, 34),
  (chapter20_id, 'mc', 'MC Question M20-12-02', 'M20-12-02', 2, 35),
  (chapter20_id, 'mc', 'MC Question M20-13-01', 'M20-13-01', 2, 36),
  (chapter20_id, 'mc', 'MC Question M20-13-02', 'M20-13-02', 2, 37),
  (chapter20_id, 'mc', 'MC Question M20-13-03', 'M20-13-03', 2, 38),
  (chapter20_id, 'mc', 'MC Question M20-13-04', 'M20-13-04', 2, 39),
  (chapter20_id, 'mc', 'MC Question M20-14-01', 'M20-14-01', 2, 40),
  (chapter20_id, 'mc', 'MC Question M20-14-02', 'M20-14-02', 2, 41),
  (chapter20_id, 'mc', 'MC Question M20-14-03', 'M20-14-03', 2, 42),
  (chapter20_id, 'mc', 'MC Question M20-15-01', 'M20-15-01', 2, 43),
  (chapter20_id, 'mc', 'MC Question M20-15-02', 'M20-15-02', 2, 44),
  (chapter20_id, 'mc', 'MC Question M20-15-03', 'M20-15-03', 2, 45),
  (chapter20_id, 'mc', 'MC Question M20-15-04', 'M20-15-04', 2, 46),
  (chapter20_id, 'mc', 'MC Question M20-15-05', 'M20-15-05', 2, 47),
  (chapter20_id, 'mc', 'MC Question M20-16-01', 'M20-16-01', 2, 48),
  (chapter20_id, 'mc', 'MC Question M20-16-02', 'M20-16-02', 2, 49),
  (chapter20_id, 'mc', 'MC Question M20-16-03', 'M20-16-03', 2, 50),
  (chapter20_id, 'mc', 'MC Question M20-18-01', 'M20-18-01', 2, 51),
  (chapter20_id, 'mc', 'MC Question M20-21-01', 'M20-21-01', 2, 52),
  (chapter20_id, 'mc', 'MC Question M20-21-02', 'M20-21-02', 2, 53),
  (chapter20_id, 'mc', 'MC Question M20-21-03', 'M20-21-03', 2, 54),
  (chapter20_id, 'mc', 'MC Question M20-22-01', 'M20-22-01', 2, 55),
  (chapter20_id, 'mc', 'MC Question M20-22-02', 'M20-22-02', 2, 56),
  (chapter20_id, 'mc', 'MC Question M20-23-01', 'M20-23-01', 2, 57),
  (chapter20_id, 'mc', 'MC Question M20-23-02', 'M20-23-02', 2, 58),
  (chapter20_id, 'mc', 'MC Question M20-23-03', 'M20-23-03', 2, 59),
  (chapter20_id, 'mc', 'MC Question M20-23-04', 'M20-23-04', 2, 60),
  (chapter20_id, 'mc', 'MC Question M20-23-05', 'M20-23-05', 2, 61),
  (chapter20_id, 'mc', 'MC Question M20-23-06', 'M20-23-06', 2, 62);
END $$;

-- Chapter 21: Governmental Accounting
DO $$
DECLARE
  chapter21_id uuid;
BEGIN
  INSERT INTO chapters (chapter_number, title, lecture_duration_minutes, order_index)
  VALUES (21, 'Chapter 21: Governmental Accounting', 126, 21)
  RETURNING id INTO chapter21_id;

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index)
  VALUES (chapter21_id, 'lecture', 'Watch Chapter 21 Lecture', 'L21', 1, 1);

  INSERT INTO tasks (chapter_id, task_type, title, task_code, round_unlock, order_index) VALUES
  (chapter21_id, 'mc', 'MC Question M21-02-01', 'M21-02-01', 2, 2),
  (chapter21_id, 'mc', 'MC Question M21-03-01', 'M21-03-01', 2, 3),
  (chapter21_id, 'mc', 'MC Question M21-04-01', 'M21-04-01', 2, 4),
  (chapter21_id, 'mc', 'MC Question M21-05-01', 'M21-05-01', 2, 5),
  (chapter21_id, 'mc', 'MC Question M21-07-01', 'M21-07-01', 2, 6),
  (chapter21_id, 'mc', 'MC Question M21-10-01', 'M21-10-01', 2, 7),
  (chapter21_id, 'mc', 'MC Question M21-10-02', 'M21-10-02', 2, 8),
  (chapter21_id, 'mc', 'MC Question M21-10-03', 'M21-10-03', 2, 9),
  (chapter21_id, 'mc', 'MC Question M21-11-01', 'M21-11-01', 2, 10),
  (chapter21_id, 'mc', 'MC Question M21-11-02', 'M21-11-02', 2, 11),
  (chapter21_id, 'mc', 'MC Question M21-11-03', 'M21-11-03', 2, 12),
  (chapter21_id, 'mc', 'MC Question M21-12-01', 'M21-12-01', 2, 13),
  (chapter21_id, 'mc', 'MC Question M21-12-02', 'M21-12-02', 2, 14);
END $$;