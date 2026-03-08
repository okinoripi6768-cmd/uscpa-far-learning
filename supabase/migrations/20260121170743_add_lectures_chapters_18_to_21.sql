/*
  # Add Lectures for Chapters 18-21

  ## Overview
  This migration adds all lectures for Chapters 18-21.

  ## Changes
  
  1. Data Inserted
    - Chapter 18: 5 lectures (18-0 to 18-4)
    - Chapter 19: 15 lectures (19-0 to 19-14)
    - Chapter 20: 25 lectures (20-0 to 20-24)
    - Chapter 21: 13 lectures (21-0 to 21-12)
*/

DO $$
DECLARE
  chapter_id_var uuid;
BEGIN
  -- Chapter 18
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 18 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, 'その他のトピック', 1, 0),
      (chapter_id_var, 1, '連邦証券法の定める公開会社の開示要件', 8, 1),
      (chapter_id_var, 2, '公開企業の中間報告に対する報告要件', 7, 2),
      (chapter_id_var, 3, '特別目的フレームワーク（その他の包括的会計基準）', 5, 3),
      (chapter_id_var, 4, '外貨建取引における取引時の換算と期末及び決済時の換算', 0, 4)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 19
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 19 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '財務指標と経営指標', 3, 0),
      (chapter_id_var, 1, '比率分析（1）デュポン・システム', 9, 1),
      (chapter_id_var, 2, '比率分析（2）収益性の分析', 4, 2),
      (chapter_id_var, 3, '比率分析（3-a）効率性の分析 回転率', 6, 3),
      (chapter_id_var, 4, '比率分析（3-b）効率性の分析 回転日数', 4, 4),
      (chapter_id_var, 5, '比率分析（4）安全性の分析', 5, 5),
      (chapter_id_var, 6, '原価態様分析', 5, 6),
      (chapter_id_var, 7, 'コスト予測の方法', 20, 7),
      (chapter_id_var, 8, 'CVP分析の重要な前提条件', 13, 8),
      (chapter_id_var, 9, '図表によるCVP分析', 6, 9),
      (chapter_id_var, 10, '数式によるCVP分析', 20, 10),
      (chapter_id_var, 11, '投下資本利益率', 6, 11),
      (chapter_id_var, 12, 'ROEの3つの決定要因', 10, 12),
      (chapter_id_var, 13, '資本構成に係る比率分析', 10, 13),
      (chapter_id_var, 14, '1株当たりの諸比率', 0, 14)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 20
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 20 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '非政府系の非営利組織', 1, 0),
      (chapter_id_var, 1, '非政府系の非営利組織（1）概要', 4, 1),
      (chapter_id_var, 2, '非政府系の非営利組織（2）一般目的の外部公開用途の完全な財務諸表', 4, 2),
      (chapter_id_var, 3, '非政府系の非営利組織（3）正味資産の区分', 9, 3),
      (chapter_id_var, 4, '非政府系の非営利組織（4）財政状態計算書', 6, 4),
      (chapter_id_var, 5, '非政府系の非営利組織（5-a）活動計算書', 14, 5),
      (chapter_id_var, 6, '非政府系の非営利組織（5-b）収益の認識', 4, 6),
      (chapter_id_var, 7, '非政府系の非営利組織（5-c）寄付者からの使途制限のある正味資産', 5, 7),
      (chapter_id_var, 8, '非政府系の非営利組織（5-d）固定資産取得に関して「寄付者からの使途制限のある正味資産」', 3, 8),
      (chapter_id_var, 9, '誓約（1）単年度', 7, 9),
      (chapter_id_var, 10, '誓約（2）複数年度', 5, 10),
      (chapter_id_var, 11, '無償提供されたサービス', 3, 11),
      (chapter_id_var, 12, '蒐集品', 3, 12),
      (chapter_id_var, 13, '条件付き約束', 6, 13),
      (chapter_id_var, 14, '仮受寄付金', 6, 14),
      (chapter_id_var, 15, '金融資産の評価', 4, 15),
      (chapter_id_var, 16, '非政府系の非営利組織―キャッシュ・フロー計算書', 10, 16),
      (chapter_id_var, 17, '非政府系の非営利組織―受益権分割契約', 3, 17),
      (chapter_id_var, 18, '非政府非営利の短期大学および大学', 12, 18),
      (chapter_id_var, 19, '非政府系医療法人（1）概要', 2, 19),
      (chapter_id_var, 20, '非政府系医療法人（2）収益の認識', 9, 20),
      (chapter_id_var, 21, '非政府系医療法人（3）基本財務諸表', 1, 21),
      (chapter_id_var, 22, '非政府系医療法人（4-a）営業活動計算書（1）', 10, 22),
      (chapter_id_var, 23, '非政府系医療法人（4-b）営業活動計算書（2）', 7, 23),
      (chapter_id_var, 24, '非政府系医療法人（4-c）売買目的以外の債務証券', 3, 24)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 21
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 21 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '政府会計', 2, 0),
      (chapter_id_var, 1, '政府会計（1）米国の州および地方政府の概要', 6, 1),
      (chapter_id_var, 2, '政府会計（2）政府会計の概要', 10, 2),
      (chapter_id_var, 3, '政府会計（3）政府財務報告の利用者', 3, 3),
      (chapter_id_var, 4, 'ファンド（1）定義', 5, 4),
      (chapter_id_var, 5, 'ファンド（2） 3つの特徴', 11, 5),
      (chapter_id_var, 6, '会計認識基準と測定焦点', 3, 6),
      (chapter_id_var, 7, '修正発生主義', 9, 7),
      (chapter_id_var, 8, '一般目的地方政府における3つの活動', 4, 8),
      (chapter_id_var, 9, 'ファンド会計における11のファンド', 20, 9),
      (chapter_id_var, 10, '政府会計区分', 7, 10),
      (chapter_id_var, 11, '企業会計区分', 5, 11),
      (chapter_id_var, 12, '受託会計区分', 10, 12)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;
END $$;
