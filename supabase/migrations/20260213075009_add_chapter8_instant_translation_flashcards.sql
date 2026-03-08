/*
  # Add Chapter 8 Instant Translation Flashcards

  ## Summary
  Adds instant translation practice flashcards for Chapter 8: Bonds
  
  ## Topics Covered
  1. Bonds Basics - Classification and characteristics
  2. Pricing & Issuance - Market rates and issue prices
  3. Effective Interest Method - Amortization calculations
  4. Issuance Entries - Journal entries and accounting treatment
  5. Premium vs Discount - Comparison and effects
  6. Issue Costs & Sinking Fund - Additional bond topics
  7. Early Retirement - Bond extinguishment

  ## Format
  Each flashcard contains:
  - Short Japanese sentence
  - Target English translation
  - Difficulty level (basic/intermediate/advanced)
  - Keywords for reference
  
  ## Total Flashcards
  70 flashcards organized into 7 topic groups (10 each)
*/

-- Get Chapter 8 ID
DO $$
DECLARE
  v_chapter_id uuid;
BEGIN
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 8;

  -- GROUP 1: Bonds Basics (社債の基礎)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Bonds Basics', '社債は長期負債として分類される。', 'Bonds are classified as long-term liabilities.', 'basic', 'bonds, long-term liabilities, classified', 1),
    (v_chapter_id, 'Bonds Basics', '社債は投資家から資金を調達するために発行される。', 'Bonds are issued to raise funds from investors.', 'basic', 'bonds, issued, raise funds, investors', 2),
    (v_chapter_id, 'Bonds Basics', '1年以内の返済部分は流動負債である。', 'The current portion is a current liability.', 'basic', 'current portion, current liability', 3),
    (v_chapter_id, 'Bonds Basics', '無担保社債はデベンチャーと呼ばれる。', 'Unsecured bonds are called debentures.', 'intermediate', 'unsecured bonds, debentures', 4),
    (v_chapter_id, 'Bonds Basics', '転換社債は株式に転換可能である。', 'Convertible bonds can be converted into shares.', 'intermediate', 'convertible bonds, converted, shares', 5),
    (v_chapter_id, 'Bonds Basics', '社債契約は利率と満期日を定める。', 'The bond agreement specifies the rate and maturity.', 'intermediate', 'bond agreement, rate, maturity', 6),
    (v_chapter_id, 'Bonds Basics', '社債は額面金額で表示される。', 'Bonds are stated at face value.', 'basic', 'bonds, stated, face value', 7),
    (v_chapter_id, 'Bonds Basics', '満期日は元本返済日である。', 'The maturity date is when principal is repaid.', 'basic', 'maturity date, principal, repaid', 8),
    (v_chapter_id, 'Bonds Basics', '社債は市場で売買できる。', 'Bonds can be traded in the market.', 'basic', 'bonds, traded, market', 9),
    (v_chapter_id, 'Bonds Basics', '社債発行は資金調達の一形態である。', 'Issuing bonds is a form of financing.', 'basic', 'issuing bonds, financing', 10);

  -- GROUP 2: Pricing & Issuance (発行価格の決定)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Pricing & Issuance', 'クーポン利率は契約上の利率である。', 'The coupon rate is the stated interest rate.', 'intermediate', 'coupon rate, stated interest rate', 11),
    (v_chapter_id, 'Pricing & Issuance', '市場利率は発行価格を決定する。', 'The market rate determines the issue price.', 'intermediate', 'market rate, determines, issue price', 12),
    (v_chapter_id, 'Pricing & Issuance', '市場利率が高いとディスカウント発行となる。', 'A higher market rate results in a discount.', 'intermediate', 'higher market rate, discount', 13),
    (v_chapter_id, 'Pricing & Issuance', '市場利率が低いとプレミアム発行となる。', 'A lower market rate results in a premium.', 'intermediate', 'lower market rate, premium', 14),
    (v_chapter_id, 'Pricing & Issuance', '額面で発行された。', 'The bonds were issued at par.', 'basic', 'issued at par', 15),
    (v_chapter_id, 'Pricing & Issuance', '発行価格は現在価値で計算される。', 'The issue price is based on present value.', 'intermediate', 'issue price, present value', 16),
    (v_chapter_id, 'Pricing & Issuance', '半年ごとに利息が支払われる。', 'Interest is paid semiannually.', 'basic', 'interest, paid semiannually', 17),
    (v_chapter_id, 'Pricing & Issuance', '利息支払額は額面×クーポン利率である。', 'Cash interest equals face value times coupon rate.', 'intermediate', 'cash interest, face value, coupon rate', 18),
    (v_chapter_id, 'Pricing & Issuance', '発行価格が額面より低かった。', 'The issue price was below face value.', 'basic', 'issue price, below face value', 19),
    (v_chapter_id, 'Pricing & Issuance', '発行価格が額面より高かった。', 'The issue price was above face value.', 'basic', 'issue price, above face value', 20);

  -- GROUP 3: Effective Interest Method (実効金利法)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Effective Interest Method', '実効金利法では帳簿価額に市場利率を掛ける。', 'Under the effective interest method, interest equals carrying amount times market rate.', 'advanced', 'effective interest method, carrying amount, market rate', 21),
    (v_chapter_id, 'Effective Interest Method', '利息費用は期間ごとに変化する。', 'Interest expense changes each period.', 'intermediate', 'interest expense, changes, each period', 22),
    (v_chapter_id, 'Effective Interest Method', 'ディスカウントは徐々に償却される。', 'The discount is amortized over time.', 'intermediate', 'discount, amortized, over time', 23),
    (v_chapter_id, 'Effective Interest Method', 'プレミアムも償却される。', 'The premium is also amortized.', 'basic', 'premium, amortized', 24),
    (v_chapter_id, 'Effective Interest Method', '帳簿価額は満期に向かって額面に近づく。', 'The carrying value moves toward face value.', 'intermediate', 'carrying value, moves toward, face value', 25),
    (v_chapter_id, 'Effective Interest Method', '利息費用は現金支払額と異なる場合がある。', 'Interest expense may differ from cash paid.', 'intermediate', 'interest expense, differ, cash paid', 26),
    (v_chapter_id, 'Effective Interest Method', '市場利率は一定である。', 'The effective rate remains constant.', 'basic', 'effective rate, remains constant', 27),
    (v_chapter_id, 'Effective Interest Method', '償却額は利息費用と現金利息の差である。', 'Amortization equals interest expense minus cash interest.', 'intermediate', 'amortization, interest expense, cash interest', 28),
    (v_chapter_id, 'Effective Interest Method', 'ディスカウント発行では帳簿価額が増加する。', 'With a discount, carrying value increases.', 'intermediate', 'discount, carrying value, increases', 29),
    (v_chapter_id, 'Effective Interest Method', 'プレミアム発行では帳簿価額が減少する。', 'With a premium, carrying value decreases.', 'intermediate', 'premium, carrying value, decreases', 30);

  -- GROUP 4: Issuance Entries (発行時の仕訳)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Issuance Entries', '発行時に現金を借方に計上する。', 'Cash is debited at issuance.', 'basic', 'cash, debited, issuance', 31),
    (v_chapter_id, 'Issuance Entries', '社債は額面金額で貸方計上する。', 'Bonds payable are credited at face value.', 'basic', 'bonds payable, credited, face value', 32),
    (v_chapter_id, 'Issuance Entries', 'ディスカウントは控除勘定である。', 'Discount is a contra account.', 'intermediate', 'discount, contra account', 33),
    (v_chapter_id, 'Issuance Entries', 'プレミアムは加算勘定である。', 'Premium is an adjunct account.', 'intermediate', 'premium, adjunct account', 34),
    (v_chapter_id, 'Issuance Entries', '利払い日の間に発行された。', 'The bonds were issued between interest dates.', 'intermediate', 'issued, between interest dates', 35),
    (v_chapter_id, 'Issuance Entries', '投資家から未払利息を受け取る。', 'Accrued interest is collected from investors.', 'intermediate', 'accrued interest, collected, investors', 36),
    (v_chapter_id, 'Issuance Entries', '次回利払い時に全額支払う。', 'Full interest is paid on the next payment date.', 'intermediate', 'full interest, next payment date', 37),
    (v_chapter_id, 'Issuance Entries', '利息収益は発行体には影響しない。', 'Interest revenue does not affect the issuer.', 'intermediate', 'interest revenue, not affect, issuer', 38),
    (v_chapter_id, 'Issuance Entries', '発行時の仕訳が記録された。', 'The issuance entry was recorded.', 'basic', 'issuance entry, recorded', 39),
    (v_chapter_id, 'Issuance Entries', '発行価格は帳簿価額の開始点である。', 'Issue price becomes initial carrying amount.', 'intermediate', 'issue price, initial carrying amount', 40);

  -- GROUP 5: Premium vs Discount (プレミアムとディスカウントの比較)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Premium vs Discount', 'プレミアム発行では利息費用が現金利息より少ない。', 'With a premium, interest expense is lower than cash interest.', 'intermediate', 'premium, interest expense, lower', 41),
    (v_chapter_id, 'Premium vs Discount', 'ディスカウント発行では利息費用が多い。', 'With a discount, interest expense is higher.', 'intermediate', 'discount, interest expense, higher', 42),
    (v_chapter_id, 'Premium vs Discount', 'プレミアムは満期まで減少する。', 'The premium decreases over time.', 'basic', 'premium, decreases, over time', 43),
    (v_chapter_id, 'Premium vs Discount', 'ディスカウントは満期まで増加する。', 'The discount increases toward face value.', 'basic', 'discount, increases, face value', 44),
    (v_chapter_id, 'Premium vs Discount', '両者とも満期には帳簿価額が一致する。', 'Both reach face value at maturity.', 'intermediate', 'both, face value, maturity', 45),
    (v_chapter_id, 'Premium vs Discount', '市場利率の違いが原因である。', 'The difference is caused by market rates.', 'intermediate', 'difference, caused by, market rates', 46),
    (v_chapter_id, 'Premium vs Discount', '利息費用の計算方法は同じである。', 'The calculation method is the same.', 'basic', 'calculation method, same', 47),
    (v_chapter_id, 'Premium vs Discount', '帳簿価額が基礎となる。', 'The carrying amount is the base.', 'basic', 'carrying amount, base', 48),
    (v_chapter_id, 'Premium vs Discount', 'ディスカウントは追加利息のように働く。', 'A discount acts like extra interest.', 'intermediate', 'discount, acts like, extra interest', 49),
    (v_chapter_id, 'Premium vs Discount', 'プレミアムは前払い利息のように働く。', 'A premium acts like prepaid interest.', 'intermediate', 'premium, acts like, prepaid interest', 50);

  -- GROUP 6: Issue Costs & Sinking Fund (発行費用と減債基金)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Issue Costs & Sinking Fund', '社債発行費には法律費用が含まれる。', 'Bond issue costs include legal fees.', 'intermediate', 'bond issue costs, legal fees', 51),
    (v_chapter_id, 'Issue Costs & Sinking Fund', '引受手数料も発行費に含まれる。', 'Underwriting fees are included.', 'intermediate', 'underwriting fees, included', 52),
    (v_chapter_id, 'Issue Costs & Sinking Fund', '発行費は帳簿価額から控除される。', 'Issue costs reduce the carrying amount.', 'intermediate', 'issue costs, reduce, carrying amount', 53),
    (v_chapter_id, 'Issue Costs & Sinking Fund', '発行費は利息費用として償却される。', 'Issue costs are amortized as interest expense.', 'intermediate', 'issue costs, amortized, interest expense', 54),
    (v_chapter_id, 'Issue Costs & Sinking Fund', '減債基金は返済のために設定される。', 'A sinking fund is set aside for repayment.', 'intermediate', 'sinking fund, set aside, repayment', 55),
    (v_chapter_id, 'Issue Costs & Sinking Fund', '減債基金は制限付き資産である。', 'A sinking fund is a restricted asset.', 'intermediate', 'sinking fund, restricted asset', 56),
    (v_chapter_id, 'Issue Costs & Sinking Fund', '注記で開示が必要である。', 'Disclosure is required in the notes.', 'basic', 'disclosure, required, notes', 57),
    (v_chapter_id, 'Issue Costs & Sinking Fund', '毎年一定額が積み立てられる。', 'A fixed amount is deposited annually.', 'basic', 'fixed amount, deposited, annually', 58),
    (v_chapter_id, 'Issue Costs & Sinking Fund', '基金は別口座で管理される。', 'The fund is held in a separate account.', 'basic', 'fund, held, separate account', 59),
    (v_chapter_id, 'Issue Costs & Sinking Fund', '基金の存在は信用力を高める。', 'The fund improves creditworthiness.', 'intermediate', 'fund, improves, creditworthiness', 60);

  -- GROUP 7: Early Retirement (早期償還)
  
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES 
    (v_chapter_id, 'Early Retirement', '社債が満期前に償還された。', 'The bonds were retired before maturity.', 'intermediate', 'bonds, retired, before maturity', 61),
    (v_chapter_id, 'Early Retirement', '早期償還損益が認識された。', 'A gain or loss on extinguishment was recognized.', 'advanced', 'gain or loss, extinguishment, recognized', 62),
    (v_chapter_id, 'Early Retirement', '償還価格が帳簿価額より高かった。', 'The retirement price exceeded the carrying value.', 'intermediate', 'retirement price, exceeded, carrying value', 63),
    (v_chapter_id, 'Early Retirement', '償還価格が帳簿価額より低かった。', 'The retirement price was lower than carrying value.', 'intermediate', 'retirement price, lower, carrying value', 64),
    (v_chapter_id, 'Early Retirement', '未償却ディスカウントが消去された。', 'Unamortized discount was removed.', 'intermediate', 'unamortized discount, removed', 65),
    (v_chapter_id, 'Early Retirement', '未償却プレミアムも消去された。', 'Unamortized premium was removed.', 'intermediate', 'unamortized premium, removed', 66),
    (v_chapter_id, 'Early Retirement', '早期償還は再ファイナンスの一部である。', 'Early retirement may be part of refinancing.', 'intermediate', 'early retirement, refinancing', 67),
    (v_chapter_id, 'Early Retirement', '利息費用は償還日まで認識する。', 'Interest expense is recognized up to the retirement date.', 'intermediate', 'interest expense, recognized, retirement date', 68),
    (v_chapter_id, 'Early Retirement', '償還仕訳が記録された。', 'The retirement entry was recorded.', 'basic', 'retirement entry, recorded', 69),
    (v_chapter_id, 'Early Retirement', '損益は当期利益に影響する。', 'The gain or loss affects current income.', 'intermediate', 'gain or loss, affects, current income', 70);

END $$;