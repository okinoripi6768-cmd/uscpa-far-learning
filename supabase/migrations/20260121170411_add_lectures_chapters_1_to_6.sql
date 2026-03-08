/*
  # Add Lectures for Chapters 1-6

  ## Overview
  This migration adds all lectures for Chapters 1-6.

  ## Changes
  
  1. Data Inserted
    - Chapter 1: 13 lectures (1-0 to 1-12)
    - Chapter 2: 13 lectures (2-0 to 2-12)
    - Chapter 3: 28 lectures (3-0 to 3-27)
    - Chapter 4: 15 lectures (4-0 to 4-14)
    - Chapter 5: 21 lectures (5-0 to 5-20)
    - Chapter 6: 5 lectures (6-0 to 6-4)
*/

DO $$
DECLARE
  chapter_id_var uuid;
BEGIN
  -- Chapter 1
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 1 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '財務会計の基本的概念と財務諸表', 2, 0),
      (chapter_id_var, 1, '財務会計および報告', 4, 1),
      (chapter_id_var, 2, '一般に認められた会計原則', 5, 2),
      (chapter_id_var, 3, '財務会計概念書', 6, 3),
      (chapter_id_var, 4, 'ASCの構造と形式', 5, 4),
      (chapter_id_var, 5, 'ASCの定める財務諸表の表示と開示', 11, 5),
      (chapter_id_var, 6, '比較情報の表示', 4, 6),
      (chapter_id_var, 7, '貸借対照表', 8, 7),
      (chapter_id_var, 8, '損益計算書', 12, 8),
      (chapter_id_var, 9, '包括利益と包括利益計算書', 14, 9),
      (chapter_id_var, 10, '損益計算書の構成要素（1）営業利益／費用', 5, 10),
      (chapter_id_var, 11, '損益計算書の構成要素（2）その他の収益及び利益／費用及び損失', 7, 11),
      (chapter_id_var, 12, '株主持分計算書', 4, 12)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 2
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 2 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '財務諸表の表示と開示・認識と測定の概念', 7, 0),
      (chapter_id_var, 1, '開示（1）財務諸表を作成する際の会計方針の開示', 3, 1),
      (chapter_id_var, 2, '開示（2）関連当事者', 10, 2),
      (chapter_id_var, 3, '重要なリスクと不確実性についての開示', 11, 3),
      (chapter_id_var, 4, '非継続事業（1）概要', 15, 4),
      (chapter_id_var, 5, '非継続事業（2）非継続事業の事業損益の報告', 3, 5),
      (chapter_id_var, 6, '非継続事業（3）貸借対照表における非継続事業の資産および負債の表示', 3, 6),
      (chapter_id_var, 7, '非継続事業（4）開示', 4, 7),
      (chapter_id_var, 8, '非継続事業（5）事業継続中止の会計処理', 11, 8),
      (chapter_id_var, 9, '非継続事業（6）会計処理と表示', 16, 9),
      (chapter_id_var, 10, '認識と測定', 16, 10),
      (chapter_id_var, 11, '後発事象', 17, 11),
      (chapter_id_var, 12, '公正価値の測定と開示', 16, 12)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 3
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 3 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '流動資産（現金・売掛金・棚卸資産）', 3, 0),
      (chapter_id_var, 1, '流動資産の定義と主な項目', 8, 1),
      (chapter_id_var, 2, '「現金及び現金同等物」の構成要素と表示', 18, 2),
      (chapter_id_var, 3, '小切手', 9, 3),
      (chapter_id_var, 4, '銀行勘定調整', 35, 4),
      (chapter_id_var, 5, '主な支払い条件と売掛金の評価', 17, 5),
      (chapter_id_var, 6, '貸倒引当金の会計処理', 15, 6),
      (chapter_id_var, 7, '貸倒引当金の計算方法（1）売上高比率法', 9, 7),
      (chapter_id_var, 8, '貸倒引当金の計算方法（2）売掛金残高比率法', 16, 8),
      (chapter_id_var, 9, '債権の譲渡取引―定義と要件', 18, 9),
      (chapter_id_var, 10, '債権の譲渡―会計処理', 4, 10),
      (chapter_id_var, 11, '債権の証券化', 10, 11),
      (chapter_id_var, 12, 'ファクタリングの会計処理（1）リコース義務がない場合', 24, 12),
      (chapter_id_var, 13, 'ファクタリングの会計処理（2）リコース義務がある場合', 6, 13),
      (chapter_id_var, 14, '棚卸資産の定義と原価の構成要素', 15, 14),
      (chapter_id_var, 15, '貿易条件', 9, 15),
      (chapter_id_var, 16, '売上原価の認識（継続記録法と棚卸計算法)', 14, 16),
      (chapter_id_var, 17, '棚卸資産の評価方法（1）個別法', 5, 17),
      (chapter_id_var, 18, '棚卸資産の評価方法（2）先入先出法', 6, 18),
      (chapter_id_var, 19, '棚卸資産の評価方法（3）平均法', 4, 19),
      (chapter_id_var, 20, '棚卸資産の評価方法（4）後入先出法', 12, 20),
      (chapter_id_var, 21, 'ドル価値後入先出法', 15, 21),
      (chapter_id_var, 22, '棚卸資産の再測定（低価法）（１）正味実現可能価額', 19, 22),
      (chapter_id_var, 23, '棚卸資産の再測定（低価法）（２）マーケット', 22, 23),
      (chapter_id_var, 24, '購入契約', 7, 24),
      (chapter_id_var, 25, '総利益法', 5, 25),
      (chapter_id_var, 26, '売価還元法（1）概要', 7, 26),
      (chapter_id_var, 27, '売価還元法（2）原価率の計算', 19, 27)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 4
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 4 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '流動負債と偶発事象', 3, 0),
      (chapter_id_var, 1, '流動負債の定義と主な項目', 1, 1),
      (chapter_id_var, 2, '代表的な流動負債の会計処理（1）買掛金', 1, 2),
      (chapter_id_var, 3, '代表的な流動負債の会計処理（2）未払給与', 1, 3),
      (chapter_id_var, 4, '代表的な流動負債の会計処理（3）未払税金', 9, 4),
      (chapter_id_var, 5, '代表的な流動負債の会計処理（4）未払利息', 6, 5),
      (chapter_id_var, 6, '代表的な流動負債の会計処理（5）保護預り負債', 5, 6),
      (chapter_id_var, 7, '短期債務の借換え', 12, 7),
      (chapter_id_var, 8, '偶発事象の定義と認識', 7, 8),
      (chapter_id_var, 9, '偶発損失事象の開示要件', 17, 9),
      (chapter_id_var, 10, '製品保証の会計処理', 17, 10),
      (chapter_id_var, 11, '保証', 4, 11),
      (chapter_id_var, 12, '有給休暇の会計処理', 16, 12),
      (chapter_id_var, 13, '資本と負債の区分', 3, 13),
      (chapter_id_var, 14, '撤退または処分コスト債務', 5, 14)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 5
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 5 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '有形固定資産', 5, 0),
      (chapter_id_var, 1, '有形固定資産の定義と取得原価の構成要素', 9, 1),
      (chapter_id_var, 2, '資産グループの購入', 3, 2),
      (chapter_id_var, 3, '有形固定資産購入後に発生した支出', 6, 3),
      (chapter_id_var, 4, '利子コストの資産計上', 25, 4),
      (chapter_id_var, 5, '貨幣性資産と非貨幣性資産の交換の基本ルール', 8, 5),
      (chapter_id_var, 6, '非貨幣性資産の交換取引および非交換性取引', 8, 6),
      (chapter_id_var, 7, '非貨幣性資産の交換における会計処理 特例（1）', 11, 7),
      (chapter_id_var, 8, '非貨幣性資産の交換における会計処理 特例（2）', 12, 8),
      (chapter_id_var, 9, '非貨幣性資産の強制転換', 5, 9),
      (chapter_id_var, 10, '有形固定資産の購入後の測定', 5, 10),
      (chapter_id_var, 11, '減価償却の定義および種類', 4, 11),
      (chapter_id_var, 12, '定額法', 3, 12),
      (chapter_id_var, 13, '級数法', 4, 13),
      (chapter_id_var, 14, '2倍逓減法', 6, 14),
      (chapter_id_var, 15, '生産高比例法', 3, 15),
      (chapter_id_var, 16, '資産除去債務', 17, 16),
      (chapter_id_var, 17, '長期性資産における減損', 6, 17),
      (chapter_id_var, 18, '長期性資産の減損処理プロセス', 25, 18),
      (chapter_id_var, 19, '売却により処分される予定の長期性資産と見積処分損失', 10, 19),
      (chapter_id_var, 20, '減耗償却', 0, 20)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;

  -- Chapter 6
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 6 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '無形資産', 4, 0),
      (chapter_id_var, 1, '無形資産の定義と当初認識', 6, 1),
      (chapter_id_var, 2, '無形資産の主な種類', 6, 2),
      (chapter_id_var, 3, '無形資産の認識後の測定と耐用年数', 8, 3),
      (chapter_id_var, 4, 'クラウドコンピューティング契約', 7, 4)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;
END $$;
