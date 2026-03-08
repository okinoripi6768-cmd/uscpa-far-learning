/*
  # Add Chapter 1 FAAS Roleplay Scenarios

  ## Summary
  Adds realistic FAAS roleplay scenarios for Chapter 1: Financial Statements

  ## Scenarios Covered
  1. Balance Sheet Classification Discussion
  2. Income Statement vs Cash Flow Explanation
  3. Current vs Non-Current Classification
  4. Retained Earnings Movement
  5. Financial Statement Relationships

  ## Format
  Each scenario includes:
  - Realistic Big4 FAAS context
  - Client questions requiring technical explanations
  - Model answers in professional consulting tone
  - Japanese hints for complex terms
*/

-- Get Chapter 1 ID
DO $$
DECLARE
  v_chapter1_id uuid;
BEGIN
  SELECT id INTO v_chapter1_id FROM chapters WHERE chapter_number = 1;

  -- Scenario 1: Balance Sheet Classification
  INSERT INTO faas_roleplay_scenarios (
    chapter_id, scenario_title, scenario_description, accounting_topic,
    consultant_role, client_role, key_vocabulary,
    step1_client_question, step2_explanation_prompt, step3_followup_question,
    model_answer_step2, model_answer_step3,
    japanese_hints, difficulty, estimated_time_minutes, order_index
  ) VALUES (
    v_chapter1_id,
    'Balance Sheet Classification Discussion',
    'You are meeting with a client who is confused about how to classify certain items on their balance sheet. They need clear guidance on the distinction between current and non-current assets.',
    'Balance Sheet Classification',
    'FAAS Senior Consultant',
    'Client CFO',
    '["current assets", "non-current assets", "liquidity", "one-year rule", "operating cycle"]',
    'Can you explain how we should decide whether an asset is current or non-current? I''m not clear on the criteria.',
    'Explain the classification criteria for current vs non-current assets clearly and concisely.',
    'So if we have a receivable due in 18 months, where does that go?',
    'Under US GAAP, we use the one-year rule as the primary criterion. Current assets are those expected to be converted to cash or consumed within one year or the normal operating cycle, whichever is longer. This includes cash, accounts receivable due within a year, and inventory. Non-current assets are held for longer periods, such as property, plant, equipment, and long-term investments.',
    'That receivable would be classified as a non-current asset because it extends beyond one year. We would report it under long-term receivables on the balance sheet. However, as time passes and it comes within 12 months of collection, we would reclassify it as current.',
    'operating cycle = 営業サイクル、通常は1年だが業種により異なる',
    'intermediate',
    10,
    1
  );

  -- Scenario 2: Income Statement vs Cash Flow
  INSERT INTO faas_roleplay_scenarios (
    chapter_id, scenario_title, scenario_description, accounting_topic,
    consultant_role, client_role, key_vocabulary,
    step1_client_question, step2_explanation_prompt, step3_followup_question,
    model_answer_step2, model_answer_step3,
    japanese_hints, difficulty, estimated_time_minutes, order_index
  ) VALUES (
    v_chapter1_id,
    'Income Statement vs Cash Flow Explanation',
    'A client is confused about why net income differs from cash flow. You need to explain the accrual basis of accounting in a clear, professional manner.',
    'Accrual Accounting vs Cash Basis',
    'FAAS Consultant',
    'Client Controller',
    '["accrual basis", "cash basis", "net income", "cash flow from operations", "non-cash items"]',
    'Our net income is $500,000 but our cash decreased by $200,000. How is this possible? Is something wrong?',
    'Explain why net income and cash flow differ under accrual accounting.',
    'Can you give me a specific example of what causes this difference?',
    'This is completely normal and expected. Under US GAAP, we use accrual accounting for the income statement, which means we recognize revenues when earned and expenses when incurred, regardless of cash timing. Net income includes non-cash items like depreciation, and doesn''t reflect changes in working capital. Cash flow, on the other hand, tracks actual cash movements.',
    'Certainly. Let''s say you made a large credit sale of $300,000 in December. That increases net income immediately, but cash won''t be collected until January. Also, if you purchased $150,000 of inventory with cash, that reduces cash but doesn''t hit the income statement until you sell that inventory. These timing differences explain the gap.',
    'timing difference = タイミング差異、working capital = 運転資本',
    'intermediate',
    12,
    2
  );

  -- Scenario 3: Retained Earnings Movement
  INSERT INTO faas_roleplay_scenarios (
    chapter_id, scenario_title, scenario_description, accounting_topic,
    consultant_role, client_role, key_vocabulary,
    step1_client_question, step2_explanation_prompt, step3_followup_question,
    model_answer_step2, model_answer_step3,
    japanese_hints, difficulty, estimated_time_minutes, order_index
  ) VALUES (
    v_chapter1_id,
    'Retained Earnings Reconciliation',
    'During a review engagement, the client asks you to explain how retained earnings changed during the year. You need to walk through the statement of retained earnings.',
    'Retained Earnings',
    'FAAS Senior Associate',
    'Client CEO',
    '["retained earnings", "net income", "dividends", "accumulated earnings", "appropriation"]',
    'I see retained earnings changed from $2 million to $2.3 million. What drives this change?',
    'Explain the components of the retained earnings reconciliation.',
    'If we pay dividends, does that reduce net income or just retained earnings?',
    'Retained earnings represents accumulated profits that have been retained in the business rather than distributed. The change is driven by two main items: we add net income for the period, and we subtract any dividends declared. In your case, if it increased by $300,000, that means your net income exceeded dividends paid during the year.',
    'Dividends only reduce retained earnings, not net income. Net income is calculated first on the income statement based on revenues and expenses. Then, dividends are a distribution decision made by the board of directors, which reduces retained earnings directly on the balance sheet. It''s important not to confuse these two concepts.',
    'dividends declared = 配当金の宣言（決議）、distribution = 分配',
    'basic',
    8,
    3
  );

  -- Scenario 4: Asset Valuation Question
  INSERT INTO faas_roleplay_scenarios (
    chapter_id, scenario_title, scenario_description, accounting_topic,
    consultant_role, client_role, key_vocabulary,
    step1_client_question, step2_explanation_prompt, step3_followup_question,
    model_answer_step2, model_answer_step3,
    japanese_hints, difficulty, estimated_time_minutes, order_index
  ) VALUES (
    v_chapter1_id,
    'Asset Valuation Discussion',
    'A client questions why assets on the balance sheet don''t reflect current market values. You need to explain the historical cost principle.',
    'Historical Cost Principle',
    'FAAS Manager',
    'Client CFO',
    '["historical cost", "fair value", "carrying amount", "impairment", "revaluation"]',
    'We bought our building 10 years ago for $1 million, but it''s worth $3 million now. Why doesn''t our balance sheet show the real value?',
    'Explain the historical cost principle and when fair value is used.',
    'Are there any situations where we would use current market value instead?',
    'Under US GAAP, most assets are recorded at historical cost—the amount paid at acquisition. This provides objectivity and verifiability. While we know the building has appreciated, we don''t adjust the carrying amount upward unless we sell it. The balance sheet is not intended to show current market values of all assets. We use cost less accumulated depreciation for buildings.',
    'Yes, there are exceptions. Certain financial instruments like trading securities are marked to fair value each period, with changes going through the income statement. Also, if an asset becomes impaired—meaning its value has declined below book value—we would write it down. But US GAAP generally prohibits upward revaluations for property, plant, and equipment.',
    'carrying amount = 帳簿価額、impairment = 減損、write down = 評価減',
    'intermediate',
    10,
    4
  );

  -- Scenario 5: Financial Statement Relationships
  INSERT INTO faas_roleplay_scenarios (
    chapter_id, scenario_title, scenario_description, accounting_topic,
    consultant_role, client_role, key_vocabulary,
    step1_client_question, step2_explanation_prompt, step3_followup_question,
    model_answer_step2, model_answer_step3,
    japanese_hints, difficulty, estimated_time_minutes, order_index
  ) VALUES (
    v_chapter1_id,
    'Financial Statement Articulation',
    'During an internal training session, a junior client staff member asks how the financial statements connect. You need to explain the articulation of financial statements.',
    'Financial Statement Relationships',
    'FAAS Senior Consultant',
    'Client Junior Accountant',
    '["articulation", "net income", "ending equity", "cash flow statement", "comprehensive income"]',
    'How do the three main financial statements connect to each other? I''m having trouble seeing the big picture.',
    'Explain how the income statement, balance sheet, and cash flow statement are linked.',
    'So net income appears on all three statements?',
    'Great question. The financial statements articulate through specific linkages. Net income from the income statement flows into retained earnings on the balance sheet, changing equity. The cash flow statement starts with net income and adjusts it to show how cash changed, reconciling to the cash balance on the balance sheet. Together, they provide different perspectives on the same business activities.',
    'Net income appears on two statements directly: it''s the bottom line of the income statement, and it''s the starting point in the operating activities section of the cash flow statement using the indirect method. It also indirectly affects the balance sheet by increasing retained earnings. However, net income itself is not a line item on the balance sheet—only its cumulative effect through retained earnings.',
    'articulation = 連結性・連動性、indirect method = 間接法',
    'intermediate',
    12,
    5
  );

END $$;