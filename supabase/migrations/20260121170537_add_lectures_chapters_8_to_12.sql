/*
  # Add Lectures for Chapters 8-12

  ## Overview
  This migration adds all lectures for Chapters 8-12.
  Note: Chapter 7 is skipped as no lecture data was provided.

  ## Changes
  
  1. Data Inserted
    - Chapter 8: 16 lectures (8-0 to 8-15)
    - Chapter 9: 9 lectures (9-0 to 9-8)
    - Chapter 10: 8 lectures (10-0 to 10-7)
    - Chapter 11: 18 lectures (11-0 to 11-17)
    - Chapter 12: 32 lectures (12-0 to 12-31)
*/

DO $$
DECLARE
  chapter_id_var uuid;
BEGIN
  -- Chapter 8
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 8 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '社債', 4, 0),
      (chapter_id_var, 1, '社債の定義と主な分類', 14, 1),
      (chapter_id_var, 2, '利率の種類', 12, 2),
      (chapter_id_var, 3, '社債の発行価格', 24, 3),
      (chapter_id_var, 4, '実効金利法（1）概要', 7, 4),
      (chapter_id_var, 5, '実効金利法（2）社債の発行時の会計処理と表示', 8, 5),
      (chapter_id_var, 6, '実効金利法（3）プレミアム発行', 19, 6),
      (chapter_id_var, 7, '実効金利法（4）ディスカウント発行', 14, 7),
      (chapter_id_var, 8, '実効金利法（5）利払い日の間で発行された場合の考え方', 9, 8),
      (chapter_id_var, 9, '実効金利法（6）利払い日の間で発行された場合の考え方〈設例〉', 11, 9),
      (chapter_id_var, 10, 'プレミアム発行とディスカウント発行の比較', 5, 10),
      (chapter_id_var, 11, '社債発行費に含まれる項目', 5, 11),
      (chapter_id_var, 12, '社債発行費の会計処理', 27, 12),
      (chapter_id_var, 13, '減債基金（1）概要', 5, 13),
      (chapter_id_var, 14, '減債基金（2）開示', 9, 14),
      (chapter_id_var, 15, '社債の早期償還', 7, 15)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 9
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 9 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '借手のリース会計', 4, 0),
      (chapter_id_var, 1, 'リース会計の概要', 12, 1),
      (chapter_id_var, 2, '借手の会計処理 ― リース分類の＜5条件＞', 25, 2),
      (chapter_id_var, 3, '借手の会計処理 ― リース期間と短期リース', 13, 3),
      (chapter_id_var, 4, '借手の会計処理 ― リース物件改良費', 11, 4),
      (chapter_id_var, 5, '借手の会計処理 ― リース開始日におけるリース負債と使用権資産の認識', 55, 5),
      (chapter_id_var, 6, '借手の会計処理 ― オペレーティング・リースのリース負債と使用権資産の償却', 36, 6),
      (chapter_id_var, 7, '借手の会計処理 ― ファイナンス・リースのリース負債と使用権資産の償却', 23, 7),
      (chapter_id_var, 8, '借手の会計処理 ― 表示と開示', 11, 8)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 10
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 10 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '受取手形と支払手形', 3, 0),
      (chapter_id_var, 1, '金銭貸借に手形が用いられる場合の会計処理（1）基本ルール', 28, 1),
      (chapter_id_var, 2, '金銭貸借に手形が用いられる場合の会計処理（2）明示されていない権利', 23, 2),
      (chapter_id_var, 3, '金銭貸借以外の取引に手形が用いられる場合の会計処理', 20, 3),
      (chapter_id_var, 4, '問題債務の再構築と返済条件の修正', 36, 4),
      (chapter_id_var, 5, '問題債務の再構築における債務者側の会計処理（１）', 23, 5),
      (chapter_id_var, 6, '問題債務の再構築における債務者側の会計処理（２）', 26, 6),
      (chapter_id_var, 7, '財務制限条項（コベナンツ）の遵守', 10, 7)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 11
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 11 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '顧客との契約に基づく収益の認識', 4, 0),
      (chapter_id_var, 1, '顧客との契約に基づく収益の認識（1）収益認識のための5つのステップ', 54, 1),
      (chapter_id_var, 2, '顧客との契約に基づく収益の認識（2）契約資産および契約負債の表示', 32, 2),
      (chapter_id_var, 3, '顧客との契約に基づく収益の認識（3）「均等」の概念', 11, 3),
      (chapter_id_var, 4, '顧客との契約に基づく収益の認識（4）委託販売（概要）', 4, 4),
      (chapter_id_var, 5, '顧客との契約に基づく収益の認識（5）委託販売（収益認識）', 8, 5),
      (chapter_id_var, 6, '顧客との契約に基づく収益の認識（6）委託販売（商品移動の運賃の会計処理）', 9, 6),
      (chapter_id_var, 7, '顧客との契約に基づく収益の認識（7）変動対価（測定）', 48, 7),
      (chapter_id_var, 8, '顧客との契約に基づく収益の認識（8）履行義務が時間の経過に伴い充足される契約', 3, 8),
      (chapter_id_var, 9, '顧客との契約に基づく収益の認識（9）建設業における長期工事契約（概要）', 8, 9),
      (chapter_id_var, 10, '顧客との契約に基づく収益の認識（10）建設業における長期工事契約（認識と測定）', 45, 10),
      (chapter_id_var, 11, '顧客との契約に基づく収益の認識（11）建設業における長期工事契約（設例）', 40, 11),
      (chapter_id_var, 12, '顧客との契約に基づく収益の認識（12）建設業における長期工事契約（表示）', 8, 12),
      (chapter_id_var, 13, '顧客との契約に基づく収益の認識（13）建設業における長期工事契約（損失の認識）', 53, 13),
      (chapter_id_var, 14, '顧客との契約に基づく収益の認識（14）重要な金融取引要素が含まれる場合（測定）', 25, 14),
      (chapter_id_var, 15, '顧客との契約に基づく収益の認識（15）ライセンス供与', 34, 15),
      (chapter_id_var, 16, '顧客との契約に基づく収益の認識（16）契約の変更', 14, 16),
      (chapter_id_var, 17, '顧客との契約に基づく収益の認識（17）追加で財またはサービスの提供を受ける権利', 13, 17)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 12
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 12 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '資本取引と1株当たり利益', 3, 0),
      (chapter_id_var, 1, '現金による株式の発行', 14, 1),
      (chapter_id_var, 2, '現金以外の資産による出資 (現物出資)', 6, 2),
      (chapter_id_var, 3, '普通株式とその他の有価証券を組み合わせた発行', 13, 3),
      (chapter_id_var, 4, '株式の引受申込', 5, 4),
      (chapter_id_var, 5, '自己株式（1）概要', 6, 5),
      (chapter_id_var, 6, '自己株式（2）原価法', 20, 6),
      (chapter_id_var, 7, '自己株式（3）額面価額法', 12, 7),
      (chapter_id_var, 8, '優先株式の定義', 8, 8),
      (chapter_id_var, 9, '参加型優先株式', 9, 9),
      (chapter_id_var, 10, '累積型優先株式', 7, 10),
      (chapter_id_var, 11, '配当金と株式分割（1）現金配当', 5, 11),
      (chapter_id_var, 12, '配当金と株式分割（2）現物配当', 3, 12),
      (chapter_id_var, 13, '配当金と株式分割（3）清算配当', 5, 13),
      (chapter_id_var, 14, '配当金と株式分割（4）スクリップ配当', 4, 14),
      (chapter_id_var, 15, '配当金と株式分割（5）株式配当', 11, 15),
      (chapter_id_var, 16, '配当金と株式分割（6）株式分割と株式併合', 7, 16),
      (chapter_id_var, 17, '配当金と株式分割（7）留保利益に係る制限と表示', 4, 17),
      (chapter_id_var, 18, '転換社債の概要', 7, 18),
      (chapter_id_var, 19, '転換社債の転換時における会計処理（1）簿価法', 5, 19),
      (chapter_id_var, 20, '転換社債の転換時における会計処理（2）時価法', 6, 20),
      (chapter_id_var, 21, '転換権付優先株式の転換時における会計処理', 6, 21),
      (chapter_id_var, 22, '新株予約権の概要', 6, 22),
      (chapter_id_var, 23, '新株予約権付社債と新株予約権付優先株式の発行時の会計処理', 11, 23),
      (chapter_id_var, 24, '新株予約権の行使時の会計処理', 5, 24),
      (chapter_id_var, 25, '基本的1株当たり利益（1）計算式及び分子', 13, 25),
      (chapter_id_var, 26, '基本的1株当たり利益（2）分母', 24, 26),
      (chapter_id_var, 27, '希薄化後1株当たり利益の計算が必要となる状況', 11, 27),
      (chapter_id_var, 28, '希薄化後1株当たり利益の計算（1）自己株式法', 12, 28),
      (chapter_id_var, 29, '希薄化後1株当たり利益の計算（2）転換仮定法', 21, 29),
      (chapter_id_var, 30, '1株当たり利益の表示', 7, 30),
      (chapter_id_var, 31, '1株当たり利益に関するその他の開示事項', 5, 31)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;
END $$;
