/*
  # Add Chapter 3 Practical Accounting English Flashcards

  ## Summary
  Adds practical English flashcards for Chapter 3: Cash and Receivables
  
  ## Topics Covered
  - Allowance for doubtful accounts
  - Impairment assessment
  - Fair value measurement
  - Credit risk evaluation
  - Recovery expectations

  ## Format
  Each flashcard contains:
  - Japanese prompt (front)
  - Model English answer with reasoning phrases (back)
  - Key phrases for reference
*/

-- Get Chapter 3 ID
DO $$
DECLARE
  v_chapter3_id uuid;
BEGIN
  SELECT id INTO v_chapter3_id FROM chapters WHERE chapter_number = 3;

  -- Flashcard 1: Allowance Assessment
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter3_id,
    'Allowance',
    '貸倒引当金の計上額が適切かどうか、判断基準を説明してください。',
    'The assessment of the allowance for doubtful accounts requires significant judgment based on available evidence. From a credit risk perspective, we need to evaluate historical collection patterns, current economic conditions, and customer-specific circumstances. The key consideration is whether the estimate reflects expected credit losses under the current expected credit loss model. Based on our analysis, we recommend documenting the key assumptions and sensitivity analyses to support the recorded amount.',
    'requires significant judgment, from a credit risk perspective, key consideration, based on our analysis',
    1
  );

  -- Flashcard 2: Impairment Indicators
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter3_id,
    'Impairment',
    '減損の兆候があるかどうか、現状の評価を伝える必要があります。',
    'We are evaluating whether there are indicators of impairment that require further analysis. From an impairment assessment perspective, the key consideration is whether there has been a significant increase in credit risk since initial recognition. This requires judgment about both quantitative and qualitative factors. At this stage, we are gathering information about the customer''s financial condition and payment history to inform our conclusion.',
    'evaluating whether, from an impairment assessment perspective, requires judgment, at this stage',
    2
  );

  -- Flashcard 3: Fair Value Determination
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter3_id,
    'Fair Value',
    '公正価値の算定方法について、監査人に説明が必要です。',
    'The determination of fair value involves applying appropriate valuation techniques based on available market data. From a measurement perspective, the key consideration is selecting the most appropriate method given the nature of the instrument and available inputs. This requires judgment about the reliability and relevance of different data sources. Based on our valuation approach, we are using observable market inputs where available and documenting any significant assumptions for unobservable inputs.',
    'involves applying appropriate valuation techniques, from a measurement perspective, requires judgment, based on our valuation approach',
    3
  );

  -- Flashcard 4: Credit Risk Evaluation
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter3_id,
    'Credit Risk',
    '信用リスクの変動が重要かどうか、評価のポイントを説明したい。',
    'Assessing whether the change in credit risk is significant requires careful consideration of all relevant information. From a risk management perspective, we need to evaluate both quantitative metrics and qualitative indicators. The key consideration is comparing the risk of default at the reporting date with the risk at initial recognition. Based on our current assessment, we are analyzing payment patterns, external credit ratings, and macroeconomic factors to support our judgment.',
    'requires careful consideration, from a risk management perspective, key consideration, based on our current assessment',
    4
  );

  -- Flashcard 5: Recovery Expectations
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter3_id,
    'Recovery',
    '回収可能性について、現在の見通しを慎重に伝える必要があります。',
    'Our assessment of collectability considers multiple factors including the customer''s financial position and historical payment behavior. From a recoverability perspective, the key consideration is whether there is reasonable expectation of collecting substantially all amounts due. This requires judgment and may need to be updated as circumstances change. At this stage, we are monitoring the situation closely and will adjust our estimate if new information becomes available that indicates a different outcome.',
    'assessment of collectability, from a recoverability perspective, requires judgment, at this stage, monitoring the situation closely',
    5
  );
END $$;
