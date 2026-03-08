/*
  # Add Lectures for Chapters 14-17

  ## Overview
  This migration adds all lectures for Chapters 14-17.
  Note: Chapter 13 was already added in a previous migration.

  ## Changes
  
  1. Data Inserted
    - Chapter 14: 14 lectures (14-0 to 14-13)
    - Chapter 15: 22 lectures (15-0 to 15-21)
    - Chapter 16: 13 lectures (16-0 to 16-12)
    - Chapter 17: 7 lectures (17-0 to 17-6)
*/

DO $$
DECLARE
  chapter_id_var uuid;
BEGIN
  -- Chapter 14
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 14 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '連結財務諸表の作成と企業結合後の調整', 2, 0),
      (chapter_id_var, 1, '企業結合の基礎的概念', 13, 1),
      (chapter_id_var, 2, '連結財務諸表の作成（1）概要', 2, 2),
      (chapter_id_var, 3, '連結財務諸表の作成（2）非支配持分のないケース', 9, 3),
      (chapter_id_var, 4, '連結財務諸表の作成（3）非支配持分のあるケース', 12, 4),
      (chapter_id_var, 5, '連結財務諸表の作成（4）非支配持分の表示', 2, 5),
      (chapter_id_var, 6, '企業結合後の調整（1）概要', 3, 6),
      (chapter_id_var, 7, '企業結合後の調整（2-a）売上及び債権・債務の調整―全部保有', 8, 7),
      (chapter_id_var, 8, '企業結合後の調整（2-b）売上及び債権・債務の調整―全部売却', 5, 8),
      (chapter_id_var, 9, '企業結合後の調整（2-c）売上及び債権・債務の調整―一部保有', 7, 9),
      (chapter_id_var, 10, '企業結合後の調整（3）有形固定資産の売買の調整', 6, 10),
      (chapter_id_var, 11, '企業結合後の調整（4）社債に係る調整', 4, 11),
      (chapter_id_var, 12, '企業結合後の調整（5）配当に係る調整', 7, 12),
      (chapter_id_var, 13, '連結財務諸表に関わる開示事項', 5, 13)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 15
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 15 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '税効果会計', 3, 0),
      (chapter_id_var, 1, '税効果会計の目的', 10, 1),
      (chapter_id_var, 2, '税引前利益と課税所得との差異', 15, 2),
      (chapter_id_var, 3, '永久差異と一時差異', 8, 3),
      (chapter_id_var, 4, '将来加算一時差異と将来減算一時差異', 10, 4),
      (chapter_id_var, 5, '繰延税金負債と繰延税金資産', 8, 5),
      (chapter_id_var, 6, '代表的な一時差異項目（1）減価償却費', 9, 6),
      (chapter_id_var, 7, '代表的な一時差異項目（2）前払費用', 5, 7),
      (chapter_id_var, 8, '代表的な一時差異項目（3）製品保証引当金繰入額', 5, 8),
      (chapter_id_var, 9, '代表的な一時差異項目（4）偶発債務による損失', 5, 9),
      (chapter_id_var, 10, '代表的な一時差異項目（5）前受収益', 4, 10),
      (chapter_id_var, 11, '代表的な一時差異項目（6）掛売り', 4, 11),
      (chapter_id_var, 12, '代表的な一時差異項目（7）強制転換による利得', 4, 12),
      (chapter_id_var, 13, '繰延税金負債 (資産) の計算に用いる税率', 5, 13),
      (chapter_id_var, 14, '損益計算書上の税金費用の調整', 13, 14),
      (chapter_id_var, 15, '繰延税金負債 (資産) の区分表示', 5, 15),
      (chapter_id_var, 16, '繰延税金資産に対する評価の引き下げ', 8, 16),
      (chapter_id_var, 17, '特殊な一時差異項目（1）持分法による利益', 9, 17),
      (chapter_id_var, 18, '特殊な一時差異項目（2）欠損金の繰延控除', 15, 18),
      (chapter_id_var, 19, '代表的な永久差異項目', 9, 19),
      (chapter_id_var, 20, '税務申告書を用いた税金の算出と税引前利益からの調整', 4, 20),
      (chapter_id_var, 21, '不確実な税務上のポジション', 0, 21)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 16
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 16 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, 'キャッシュ・フロー計算書', 3, 0),
      (chapter_id_var, 1, 'キャッシュ・フロー計算書の目的', 6, 1),
      (chapter_id_var, 2, '現金と現金同等物', 6, 2),
      (chapter_id_var, 3, 'キャッシュ・フロー計算書における3つのカテゴリー', 7, 3),
      (chapter_id_var, 4, '直接法と間接法によるキャッシュ・フロー計算書の違い', 8, 4),
      (chapter_id_var, 5, '営業活動の定義', 6, 5),
      (chapter_id_var, 6, '投資活動の定義', 4, 6),
      (chapter_id_var, 7, '財務活動の定義', 6, 7),
      (chapter_id_var, 8, '直接法によるキャッシュ・フロー計算書の作成', 16, 8),
      (chapter_id_var, 9, '間接法における営業キャッシュ・フローの算出（1）資産勘定残高の増減と利益の加減調整', 10, 9),
      (chapter_id_var, 10, '間接法における営業キャッシュ・フローの算出（2）負債勘定残高の増減と利益の加減調整', 4, 10),
      (chapter_id_var, 11, '間接法における営業キャッシュ・フローの算出（3）収益・費用項目と、現金収入・支出の差異の調整', 8, 11),
      (chapter_id_var, 12, '間接法における営業キャッシュ・フローの算出（4）二重計上の防止', 5, 12)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 17
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 17 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '会計上の変更と誤謬の修正', 1, 0),
      (chapter_id_var, 1, '会計上の変更（1）3つの概念', 11, 1),
      (chapter_id_var, 2, '会計上の変更（2）2種類の会計処理方法', 4, 2),
      (chapter_id_var, 3, '会計上の変更（3）プロスペクティブ法', 8, 3),
      (chapter_id_var, 4, '会計上の変更（4）遡及的適用', 9, 4),
      (chapter_id_var, 5, '誤謬の修正', 8, 5),
      (chapter_id_var, 6, '相殺的誤謬', 12, 6)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;
END $$;
