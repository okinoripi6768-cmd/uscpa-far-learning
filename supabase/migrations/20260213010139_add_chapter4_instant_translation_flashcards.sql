/*
  # Add Chapter 4 Instant Translation Flashcards

  ## Summary
  Adds instant translation practice flashcards for Chapter 4: Current Liabilities and Contingencies
  
  ## Topics Covered
  - Refinancing of short-term debt
  - Escrow accounts and accruals
  - Contingent losses and liabilities
  - Covenant violations and waivers
  - Mixed liability topics

  ## Format
  Each flashcard contains:
  - Short Japanese sentence
  - Target English translation
  - Difficulty level (basic/intermediate/advanced)
  - Keywords for reference
  
  ## Total Flashcards
  50 flashcards organized into 5 topic groups
*/

-- Get Chapter ID for Current Liabilities and Contingencies
DO $$
DECLARE
  v_chapter_id uuid;
BEGIN
  SELECT id INTO v_chapter_id FROM chapters WHERE title = 'Current Liabilities and Contingencies';

  -- GROUP 1: Refinancing (借換)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Refinancing', '会社は短期借入金を長期借入金に借り換えた。', 'The company refinanced a short-term loan into a long-term loan.', 'intermediate', 'refinance, short-term, long-term', 1),
    (v_chapter_id, 'Refinancing', '借換契約が期末前に完了していれば、負債は長期に分類される。', 'If the refinancing is completed before year-end, the liability is classified as long-term.', 'intermediate', 'refinancing, year-end, classification, long-term', 2),
    (v_chapter_id, 'Refinancing', '借換の意思だけでは不十分である。', 'Intent alone is not sufficient for refinancing classification.', 'intermediate', 'intent, sufficient, refinancing', 3),
    (v_chapter_id, 'Refinancing', '会社は借入条件を再交渉した。', 'The company renegotiated the borrowing terms.', 'basic', 'renegotiate, borrowing terms', 4),
    (v_chapter_id, 'Refinancing', '返済期限が延長された。', 'The maturity date was extended.', 'basic', 'maturity date, extended', 5),
    (v_chapter_id, 'Refinancing', '新しい融資契約は期末後に締結された。', 'The new financing agreement was signed after year-end.', 'intermediate', 'financing agreement, signed, after year-end', 6),
    (v_chapter_id, 'Refinancing', '短期部分は流動負債として表示される。', 'The current portion is presented as a current liability.', 'intermediate', 'current portion, current liability, presented', 7),
    (v_chapter_id, 'Refinancing', '契約違反により負債は即時返済可能となった。', 'Due to a covenant violation, the debt became callable.', 'advanced', 'covenant violation, callable debt', 8),
    (v_chapter_id, 'Refinancing', '銀行は返済要求を放棄した。', 'The bank waived the repayment demand.', 'intermediate', 'waived, repayment demand', 9),
    (v_chapter_id, 'Refinancing', '借換能力が証明された。', 'The ability to refinance was demonstrated.', 'intermediate', 'ability, refinance, demonstrated', 10);

  -- GROUP 2: Escrow & Accruals (エスクロー・未払)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Escrow & Accruals', '会社は税金支払いのためにエスクロー口座に資金を預けた。', 'The company deposited funds into an escrow account for tax payments.', 'intermediate', 'escrow account, deposited funds, tax payments', 11),
    (v_chapter_id, 'Escrow & Accruals', 'エスクロー資金は制限付き資産として扱われる場合がある。', 'Escrow funds may be treated as restricted assets.', 'intermediate', 'escrow funds, restricted assets, treated', 12),
    (v_chapter_id, 'Escrow & Accruals', '未払い利息が期末に計上された。', 'Accrued interest was recorded at year-end.', 'basic', 'accrued interest, recorded, year-end', 13),
    (v_chapter_id, 'Escrow & Accruals', '利息費用は発生主義で認識される。', 'Interest expense is recognized on an accrual basis.', 'intermediate', 'interest expense, accrual basis, recognized', 14),
    (v_chapter_id, 'Escrow & Accruals', '未払い税金は流動負債として表示される。', 'Accrued taxes are presented as current liabilities.', 'basic', 'accrued taxes, current liabilities, presented', 15),
    (v_chapter_id, 'Escrow & Accruals', '会社は未払い手数料を計上した。', 'The company recorded accrued commissions.', 'basic', 'recorded, accrued commissions', 16),
    (v_chapter_id, 'Escrow & Accruals', '給与は支払前でも費用として認識される。', 'Salaries are recognized as expenses even before payment.', 'intermediate', 'salaries, recognized, expenses, before payment', 17),
    (v_chapter_id, 'Escrow & Accruals', '利息は時間の経過に伴って発生する。', 'Interest accrues over time.', 'basic', 'interest, accrues, over time', 18),
    (v_chapter_id, 'Escrow & Accruals', '支払期限は翌期である。', 'The payment is due in the next period.', 'basic', 'payment, due, next period', 19),
    (v_chapter_id, 'Escrow & Accruals', 'エスクロー残高は契約により制限されている。', 'The escrow balance is restricted by contract.', 'intermediate', 'escrow balance, restricted, contract', 20);

  -- GROUP 3: Contingencies (偶発損失)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Contingencies', '偶発損失は発生可能性が高い場合に認識される。', 'A contingent loss is recognized when it is probable.', 'intermediate', 'contingent loss, recognized, probable', 21),
    (v_chapter_id, 'Contingencies', '金額が合理的に見積もれる必要がある。', 'The amount must be reasonably estimable.', 'intermediate', 'amount, reasonably estimable', 22),
    (v_chapter_id, 'Contingencies', '偶発利得は通常認識されない。', 'Contingent gains are generally not recognized.', 'intermediate', 'contingent gains, generally not recognized', 23),
    (v_chapter_id, 'Contingencies', '訴訟損失引当金が計上された。', 'A litigation loss provision was recorded.', 'intermediate', 'litigation, loss provision, recorded', 24),
    (v_chapter_id, 'Contingencies', '会社は保証債務を負っている。', 'The company has a warranty obligation.', 'basic', 'warranty obligation', 25),
    (v_chapter_id, 'Contingencies', '損失は注記で開示される。', 'The loss is disclosed in the notes.', 'basic', 'loss, disclosed, notes', 26),
    (v_chapter_id, 'Contingencies', '発生可能性が低い場合は認識しない。', 'If the likelihood is remote, it is not recognized.', 'intermediate', 'likelihood, remote, not recognized', 27),
    (v_chapter_id, 'Contingencies', '弁護士の意見が考慮された。', 'The attorney''s opinion was considered.', 'basic', 'attorney, opinion, considered', 28),
    (v_chapter_id, 'Contingencies', '会社は将来の訴訟リスクを評価した。', 'The company assessed future litigation risk.', 'intermediate', 'assessed, litigation risk', 29),
    (v_chapter_id, 'Contingencies', '損失範囲の最小額を計上した。', 'The company recorded the minimum amount of the loss range.', 'advanced', 'recorded, minimum amount, loss range', 30);

  -- GROUP 4: Covenant Violations (契約違反と借換)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Covenant Violations', '契約違反により借入金は流動負債となった。', 'Due to a covenant violation, the debt became current.', 'advanced', 'covenant violation, debt, current', 31),
    (v_chapter_id, 'Covenant Violations', '銀行は期末前に免除書を発行した。', 'The bank issued a waiver before year-end.', 'intermediate', 'issued, waiver, before year-end', 32),
    (v_chapter_id, 'Covenant Violations', '借換契約により支払期限が12か月以上延長された。', 'The refinancing extended the maturity beyond 12 months.', 'advanced', 'refinancing, extended, maturity, 12 months', 33),
    (v_chapter_id, 'Covenant Violations', '会社は新しい社債を発行した。', 'The company issued new bonds.', 'basic', 'issued, bonds', 34),
    (v_chapter_id, 'Covenant Violations', '古い借入金は返済された。', 'The old loan was repaid.', 'basic', 'loan, repaid', 35),
    (v_chapter_id, 'Covenant Violations', '借入金は固定金利から変動金利に変更された。', 'The loan changed from fixed to variable interest.', 'intermediate', 'loan, fixed, variable interest', 36),
    (v_chapter_id, 'Covenant Violations', '追加担保が要求された。', 'Additional collateral was required.', 'intermediate', 'additional collateral, required', 37),
    (v_chapter_id, 'Covenant Violations', '契約条件は財務比率に基づいている。', 'The covenant is based on financial ratios.', 'intermediate', 'covenant, based on, financial ratios', 38),
    (v_chapter_id, 'Covenant Violations', '会社は借入条件を満たしている。', 'The company is in compliance with the debt terms.', 'intermediate', 'compliance, debt terms', 39),
    (v_chapter_id, 'Covenant Violations', '違反が修正された。', 'The violation was cured.', 'intermediate', 'violation, cured', 40);

  -- GROUP 5: Mixed Topics (混合)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Mixed Topics', '未払いコミッションは売上に基づいて計算される。', 'Accrued commissions are calculated based on sales.', 'intermediate', 'accrued commissions, calculated, based on sales', 41),
    (v_chapter_id, 'Mixed Topics', '未払い税金は見積額で計上される。', 'Accrued taxes are recorded based on estimates.', 'intermediate', 'accrued taxes, recorded, estimates', 42),
    (v_chapter_id, 'Mixed Topics', '利息は毎月計上される。', 'Interest is accrued monthly.', 'basic', 'interest, accrued monthly', 43),
    (v_chapter_id, 'Mixed Topics', '偶発損失は注記のみで開示された。', 'The contingent loss was disclosed only in the notes.', 'intermediate', 'contingent loss, disclosed, notes only', 44),
    (v_chapter_id, 'Mixed Topics', '保証費用は販売時に見積もられる。', 'Warranty expense is estimated at the time of sale.', 'intermediate', 'warranty expense, estimated, time of sale', 45),
    (v_chapter_id, 'Mixed Topics', '利得は実現時まで認識しない。', 'Gains are not recognized until realized.', 'intermediate', 'gains, not recognized, until realized', 46),
    (v_chapter_id, 'Mixed Topics', '税務調査の結果は不確実である。', 'The outcome of the tax audit is uncertain.', 'intermediate', 'outcome, tax audit, uncertain', 47),
    (v_chapter_id, 'Mixed Topics', '会社は潜在的な負債を評価している。', 'The company is evaluating potential liabilities.', 'intermediate', 'evaluating, potential liabilities', 48),
    (v_chapter_id, 'Mixed Topics', '最善の見積額を負債として計上した。', 'The best estimate was recorded as a liability.', 'intermediate', 'best estimate, recorded, liability', 49),
    (v_chapter_id, 'Mixed Topics', '引当金は期末に再評価される。', 'Provisions are reassessed at year-end.', 'intermediate', 'provisions, reassessed, year-end', 50);

END $$;