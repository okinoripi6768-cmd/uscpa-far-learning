/*
  # Add Chapter 3 Flashcards

  1. Data Insertion
    - Adds 15 flashcard terms for Chapter 3: Current Assets
    - Covers Cash, Accounts Receivable, and Inventory concepts
    - Includes common misconceptions and instant recognition phrases

  2. Flashcards Added (Current Assets)
    🔹 Cash:
    1. cash equivalents - 現金同等物
    2. restricted cash - 使用制限付き現金
    3. compensating balance - 補償残高
    4. bank overdraft - 当座貸越

    🔹 Accounts Receivable:
    5. trade receivables - 営業債権
    6. allowance for doubtful accounts - 貸倒引当金
    7. write-off - 直接償却
    8. factoring of receivables - 債権売却
    9. pledge of receivables - 債権の担保提供

    🔹 Inventory:
    10. inventory - 棚卸資産
    11. lower of cost or market (LCM) - 原価と時価の低い方
    12. net realizable value (NRV) - 正味実現可能価額
    13. consigned goods - 委託品
    14. FOB shipping point / destination - 所有権移転時点
    15. purchase commitment - 購入契約
*/

-- Insert Chapter 3 flashcards
INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'cash equivalents', '短期・高流動性投資（3か月以内）', '現金同等物
投資ではなく cash', '× すべての短期投資', 'maturity ≤ 3 months', 1
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'restricted cash', '使用制限付き現金', 'current / noncurrent 判定
使用時期次第', '× すべて非流動', 'restriction timing determines classification', 2
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'compensating balance', '補償残高', '開示 or 再分類
cash から除外される可能性', '× 費用', 'minimum balance required', 3
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'bank overdraft', '当座貸越', 'liability
cash ではない', '× マイナス現金', 'overdraft → payable', 4
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'trade receivables', '営業債権', 'AR
revenue 由来', '× notes receivable', 'from customers', 5
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'allowance for doubtful accounts', '貸倒引当金', 'contra-asset
見積り', '× 直接償却', 'estimate of uncollectible', 6
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'write-off', '直接償却', 'AR & allowance 同時減少
P/L 影響なし', '× 費用計上', 'no income statement effect', 7
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'factoring of receivables', '債権売却', 'sale or secured borrowing', '× 常に借入', 'without recourse → sale', 8
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'pledge of receivables', '債権の担保提供', '借入
ARは残る', '× 売却', 'collateral only', 9
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'inventory', '棚卸資産', 'cost or market
売却目的', '× PPE', 'held for sale', 10
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'lower of cost or market (LCM)', '原価と時価の低い方', 'market = replacement cost（制限あり）', '× selling price', 'RC with ceiling/floor', 11
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'net realizable value (NRV)', '正味実現可能価額', 'IFRS
selling price − costs', '× replacement cost', 'sales price minus costs', 12
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'consigned goods', '委託品', '所有者の在庫
consignor', '× consignment店の在庫', 'title retained', 13
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'FOB shipping point / destination', '所有権移転時点', 'inventory cutoff', '× 配送場所', 'shipping point → buyer owns in transit', 14
FROM chapters WHERE chapter_number = 3;

INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index)
SELECT id, 'purchase commitment', '購入契約', 'market < contract price → loss', '× 在庫計上', 'noncancelable + market decline → loss', 15
FROM chapters WHERE chapter_number = 3;
