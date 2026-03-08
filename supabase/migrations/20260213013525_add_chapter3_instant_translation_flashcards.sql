/*
  # Add Chapter 3 Instant Translation Flashcards

  ## Summary
  Adds instant translation practice flashcards for Chapter 3: Cash and Receivables
  
  ## Topics Covered
  - Bank reconciliation
  - Bad debt allowance and estimation methods
  - Factoring and transfer of receivables
  - Inventory valuation methods
  - Other inventory topics

  ## Format
  Each flashcard contains:
  - Short Japanese sentence
  - Target English translation
  - Difficulty level (basic/intermediate/advanced)
  - Keywords for reference
  
  ## Total Flashcards
  50 flashcards organized into 5 topic groups
*/

-- Get Chapter 3 ID
DO $$
DECLARE
  v_chapter_id uuid;
BEGIN
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 3;

  -- GROUP 1: Bank Reconciliation (銀行勘定調整)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Bank Reconciliation', '未取立小切手は銀行残高から控除する。', 'Outstanding checks are deducted from the bank balance.', 'basic', 'outstanding checks, deducted, bank balance', 1),
    (v_chapter_id, 'Bank Reconciliation', '未入金預金は銀行側に加算する。', 'Deposits in transit are added to the bank balance.', 'basic', 'deposits in transit, added, bank balance', 2),
    (v_chapter_id, 'Bank Reconciliation', '銀行手数料は帳簿側で調整する。', 'Bank charges are adjusted on the book side.', 'intermediate', 'bank charges, adjusted, book side', 3),
    (v_chapter_id, 'Bank Reconciliation', 'NSF小切手は売掛金を増加させる。', 'An NSF check increases accounts receivable.', 'intermediate', 'NSF check, increases, accounts receivable', 4),
    (v_chapter_id, 'Bank Reconciliation', '銀行誤謬は銀行残高を修正する。', 'A bank error adjusts the bank balance.', 'basic', 'bank error, adjusts, bank balance', 5),
    (v_chapter_id, 'Bank Reconciliation', '会社側の記帳ミスは帳簿を修正する。', 'A company recording error adjusts the books.', 'basic', 'recording error, adjusts, books', 6),
    (v_chapter_id, 'Bank Reconciliation', '調整後残高は一致する必要がある。', 'The adjusted balances must agree.', 'basic', 'adjusted balances, must agree', 7),
    (v_chapter_id, 'Bank Reconciliation', '利息収入は帳簿側で認識する。', 'Interest income is recorded on the book side.', 'basic', 'interest income, recorded, book side', 8),
    (v_chapter_id, 'Bank Reconciliation', '自動引落は会社が記帳する必要がある。', 'Automatic payments must be recorded by the company.', 'intermediate', 'automatic payments, recorded, company', 9),
    (v_chapter_id, 'Bank Reconciliation', '銀行勘定調整は内部統制の一部である。', 'Bank reconciliation is part of internal control.', 'intermediate', 'bank reconciliation, internal control', 10);

  -- GROUP 2: Bad Debt & Allowance (貸倒引当金)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Bad Debt & Allowance', '売上高比率法は当期の費用を重視する。', 'The percentage-of-sales method focuses on current expense.', 'intermediate', 'percentage-of-sales, focuses, current expense', 11),
    (v_chapter_id, 'Bad Debt & Allowance', '残高比率法は貸倒引当金残高を重視する。', 'The aging method focuses on the allowance balance.', 'intermediate', 'aging method, focuses, allowance balance', 12),
    (v_chapter_id, 'Bad Debt & Allowance', '貸倒費用が期末に計上された。', 'Bad debt expense was recorded at year-end.', 'basic', 'bad debt expense, recorded, year-end', 13),
    (v_chapter_id, 'Bad Debt & Allowance', '売掛金は純実現可能価額で表示される。', 'Accounts receivable are presented at net realizable value.', 'intermediate', 'accounts receivable, net realizable value', 14),
    (v_chapter_id, 'Bad Debt & Allowance', '引当金は見積りに基づいている。', 'The allowance is based on estimates.', 'basic', 'allowance, based on, estimates', 15),
    (v_chapter_id, 'Bad Debt & Allowance', '過去の回収実績が使用される。', 'Historical collection data is used.', 'basic', 'historical collection data, used', 16),
    (v_chapter_id, 'Bad Debt & Allowance', '特定の顧客残高が回収不能と判断された。', 'A specific account was deemed uncollectible.', 'intermediate', 'specific account, deemed uncollectible', 17),
    (v_chapter_id, 'Bad Debt & Allowance', '直接償却法はGAAPでは原則使用しない。', 'The direct write-off method is generally not used under GAAP.', 'advanced', 'direct write-off method, not used, GAAP', 18),
    (v_chapter_id, 'Bad Debt & Allowance', '売掛金の年齢分析が実施された。', 'An aging analysis of receivables was performed.', 'intermediate', 'aging analysis, receivables, performed', 19),
    (v_chapter_id, 'Bad Debt & Allowance', '期末に引当金が調整された。', 'The allowance was adjusted at year-end.', 'basic', 'allowance, adjusted, year-end', 20);

  -- GROUP 3: Factoring & Transfer of Receivables (売掛金譲渡)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Factoring & Transfer', '会社は売掛金をファクタリングした。', 'The company factored its receivables.', 'intermediate', 'factored, receivables', 21),
    (v_chapter_id, 'Factoring & Transfer', 'リコース義務ありで譲渡した。', 'The receivables were transferred with recourse.', 'advanced', 'transferred, with recourse', 22),
    (v_chapter_id, 'Factoring & Transfer', 'リコースなしの場合は売却として扱う。', 'Without recourse, it is treated as a sale.', 'advanced', 'without recourse, treated as sale', 23),
    (v_chapter_id, 'Factoring & Transfer', '支配が移転しているかが重要である。', 'It is important whether control has been surrendered.', 'advanced', 'control, surrendered, important', 24),
    (v_chapter_id, 'Factoring & Transfer', '証券化取引が実施された。', 'A securitization transaction was executed.', 'intermediate', 'securitization, transaction, executed', 25),
    (v_chapter_id, 'Factoring & Transfer', '保証負債が計上された。', 'A recourse liability was recorded.', 'advanced', 'recourse liability, recorded', 26),
    (v_chapter_id, 'Factoring & Transfer', '受取資金は手数料控除後である。', 'Cash proceeds are net of fees.', 'intermediate', 'cash proceeds, net of fees', 27),
    (v_chapter_id, 'Factoring & Transfer', '取引は担保付借入として扱われた。', 'The transfer was treated as a secured borrowing.', 'advanced', 'transfer, secured borrowing', 28),
    (v_chapter_id, 'Factoring & Transfer', '貿易債権が譲渡された。', 'Trade receivables were transferred.', 'basic', 'trade receivables, transferred', 29),
    (v_chapter_id, 'Factoring & Transfer', '契約条件が詳細に検討された。', 'The contract terms were carefully evaluated.', 'intermediate', 'contract terms, carefully evaluated', 30);

  -- GROUP 4: Inventory Valuation Methods (在庫評価方法)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Inventory Valuation', 'FIFOでは最初に購入した在庫が先に売れる。', 'Under FIFO, the earliest purchases are sold first.', 'basic', 'FIFO, earliest purchases, sold first', 31),
    (v_chapter_id, 'Inventory Valuation', '平均法は単価を平均化する。', 'The average method smooths unit costs.', 'basic', 'average method, smooths, unit costs', 32),
    (v_chapter_id, 'Inventory Valuation', '個別法は高価な商品に使われる。', 'Specific identification is used for unique items.', 'intermediate', 'specific identification, unique items', 33),
    (v_chapter_id, 'Inventory Valuation', '棚卸資産は原価と時価のいずれか低い方で評価する。', 'Inventory is measured at lower of cost or market.', 'intermediate', 'inventory, lower of cost or market', 34),
    (v_chapter_id, 'Inventory Valuation', '市場価格が下落した。', 'Market price declined.', 'basic', 'market price, declined', 35),
    (v_chapter_id, 'Inventory Valuation', '評価損が計上された。', 'A loss from write-down was recorded.', 'intermediate', 'loss, write-down, recorded', 36),
    (v_chapter_id, 'Inventory Valuation', 'ドル価値LIFOが適用された。', 'Dollar-value LIFO was applied.', 'intermediate', 'dollar-value LIFO, applied', 37),
    (v_chapter_id, 'Inventory Valuation', 'インフレ環境ではLIFOが利益を減少させる。', 'In inflation, LIFO reduces income.', 'intermediate', 'inflation, LIFO, reduces income', 38),
    (v_chapter_id, 'Inventory Valuation', '在庫回転率が分析された。', 'Inventory turnover was analyzed.', 'basic', 'inventory turnover, analyzed', 39),
    (v_chapter_id, 'Inventory Valuation', '期末棚卸が実施された。', 'A physical inventory count was performed.', 'basic', 'physical inventory count, performed', 40);

  -- GROUP 5: Other Inventory Topics (その他在庫トピック)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Other Inventory Topics', '不利な購入契約に対して引当金が計上された。', 'A loss provision was recorded for an onerous purchase commitment.', 'advanced', 'loss provision, onerous purchase commitment', 41),
    (v_chapter_id, 'Other Inventory Topics', '契約価格が市場価格を上回っている。', 'The contract price exceeds market price.', 'intermediate', 'contract price, exceeds, market price', 42),
    (v_chapter_id, 'Other Inventory Topics', '売価還元法で棚卸を見積もった。', 'Inventory was estimated using the retail inventory method.', 'intermediate', 'inventory, estimated, retail method', 43),
    (v_chapter_id, 'Other Inventory Topics', '原価率が計算された。', 'The cost-to-retail ratio was calculated.', 'intermediate', 'cost-to-retail ratio, calculated', 44),
    (v_chapter_id, 'Other Inventory Topics', '総利益法で期末在庫を推定した。', 'Ending inventory was estimated using the gross profit method.', 'intermediate', 'ending inventory, estimated, gross profit method', 45),
    (v_chapter_id, 'Other Inventory Topics', '売上総利益率が使用された。', 'The gross profit percentage was used.', 'basic', 'gross profit percentage, used', 46),
    (v_chapter_id, 'Other Inventory Topics', '火災後に在庫が推定された。', 'Inventory was estimated after a fire.', 'intermediate', 'inventory, estimated, after fire', 47),
    (v_chapter_id, 'Other Inventory Topics', '返品見込額が調整された。', 'Estimated returns were adjusted.', 'basic', 'estimated returns, adjusted', 48),
    (v_chapter_id, 'Other Inventory Topics', '在庫減耗が考慮された。', 'Inventory shrinkage was considered.', 'intermediate', 'inventory shrinkage, considered', 49),
    (v_chapter_id, 'Other Inventory Topics', '棚卸資産の評価は保守主義に基づく。', 'Inventory valuation follows conservatism.', 'intermediate', 'inventory valuation, conservatism', 50);

END $$;