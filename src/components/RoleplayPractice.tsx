import React, { useState, useEffect } from 'react';
import { X, ChevronLeft, ChevronRight, MessageSquare, AlertCircle, Users, Lightbulb } from 'lucide-react';
import {
  getRoleplayScenariosByChapter,
  updateRoleplayProgress,
  getRoleplayStats,
  RoleplayScenarioWithProgress
} from '../lib/roleplayService';

interface RoleplayPracticeProps {
  chapterId: string;
  onClose: () => void;
}

type Step = 'intro' | 'question1' | 'answer1' | 'question2' | 'answer2' | 'complete';

export function RoleplayPractice({ chapterId, onClose }: RoleplayPracticeProps) {
  const [scenarios, setScenarios] = useState<RoleplayScenarioWithProgress[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [currentStep, setCurrentStep] = useState<Step>('intro');
  const [loading, setLoading] = useState(true);
  const [myAnswer1, setMyAnswer1] = useState('');
  const [myAnswer2, setMyAnswer2] = useState('');
  const [stats, setStats] = useState({ total: 0, notStarted: 0, practicing: 0, completed: 0, completionRate: 0 });

  useEffect(() => {
    loadScenarios();
  }, [chapterId]);

  const loadScenarios = async () => {
    try {
      setLoading(true);
      const [scenarioData, statsData] = await Promise.all([
        getRoleplayScenariosByChapter(chapterId),
        getRoleplayStats(chapterId)
      ]);
      setScenarios(scenarioData);
      setStats(statsData);

      if (scenarioData.length > 0 && scenarioData[0].progress) {
        setMyAnswer1(scenarioData[0].progress.my_answer_step2 || '');
        setMyAnswer2(scenarioData[0].progress.my_answer_step3 || '');
      }
    } catch (error) {
      console.error('Failed to load roleplay scenarios:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleStatusUpdate = async (completed: boolean) => {
    try {
      const currentScenario = scenarios[currentIndex];
      await updateRoleplayProgress(currentScenario.id, {
        completed,
        my_answer_step2: myAnswer1,
        my_answer_step3: myAnswer2
      });
      await loadScenarios();
    } catch (error) {
      console.error('Failed to update progress:', error);
    }
  };

  const goToNextScenario = () => {
    if (currentIndex < scenarios.length - 1) {
      setCurrentIndex(currentIndex + 1);
      setCurrentStep('intro');
      setMyAnswer1(scenarios[currentIndex + 1].progress?.my_answer_step2 || '');
      setMyAnswer2(scenarios[currentIndex + 1].progress?.my_answer_step3 || '');
    }
  };

  const goToPreviousScenario = () => {
    if (currentIndex > 0) {
      setCurrentIndex(currentIndex - 1);
      setCurrentStep('intro');
      setMyAnswer1(scenarios[currentIndex - 1].progress?.my_answer_step2 || '');
      setMyAnswer2(scenarios[currentIndex - 1].progress?.my_answer_step3 || '');
    }
  };

  const handleStepNext = () => {
    const stepOrder: Step[] = ['intro', 'question1', 'answer1', 'question2', 'answer2', 'complete'];
    const currentStepIndex = stepOrder.indexOf(currentStep);
    if (currentStepIndex < stepOrder.length - 1) {
      setCurrentStep(stepOrder[currentStepIndex + 1]);
    }
  };

  const handleStepBack = () => {
    const stepOrder: Step[] = ['intro', 'question1', 'answer1', 'question2', 'answer2', 'complete'];
    const currentStepIndex = stepOrder.indexOf(currentStep);
    if (currentStepIndex > 0) {
      setCurrentStep(stepOrder[currentStepIndex - 1]);
    }
  };

  if (loading) {
    return (
      <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
        <div className="bg-white rounded-xl p-8">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
        </div>
      </div>
    );
  }

  if (scenarios.length === 0) {
    return (
      <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
        <div className="bg-white rounded-xl p-8 max-w-md">
          <div className="text-center">
            <AlertCircle className="w-16 h-16 text-gray-400 mx-auto mb-4" />
            <h3 className="text-xl font-semibold mb-2">No Scenarios Available</h3>
            <p className="text-gray-600 mb-6">
              There are no FAAS roleplay scenarios for this chapter yet.
            </p>
            <button
              onClick={onClose}
              className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
            >
              Close
            </button>
          </div>
        </div>
      </div>
    );
  }

  const currentScenario = scenarios[currentIndex];
  const keyVocab = currentScenario.key_vocabulary;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-3 sm:p-4 overflow-y-auto">
      <div className="bg-white rounded-xl shadow-2xl w-full max-w-5xl my-auto max-h-[95vh] sm:max-h-[90vh] flex flex-col">
        <div className="p-4 sm:p-6 border-b border-gray-200 flex items-center justify-between flex-shrink-0 bg-gradient-to-r from-blue-600 to-blue-700 text-white">
          <div className="flex items-center gap-3">
            <Users className="w-6 h-6" />
            <div>
              <h2 className="text-xl sm:text-2xl font-bold">
                FAAS Roleplay Practice
              </h2>
              <p className="text-sm text-blue-100">Big4 Client Meeting Simulation</p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-2 hover:bg-blue-800 rounded-lg transition-colors"
          >
            <X className="w-6 h-6" />
          </button>
        </div>

        <div className="p-4 sm:p-6 space-y-4 overflow-y-auto flex-1">
          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
            <div className="grid grid-cols-4 gap-4 text-center">
              <div>
                <div className="text-2xl font-bold text-blue-600">{stats.total}</div>
                <div className="text-xs text-gray-600">Total</div>
              </div>
              <div>
                <div className="text-2xl font-bold text-gray-400">{stats.notStarted}</div>
                <div className="text-xs text-gray-600">Not Started</div>
              </div>
              <div>
                <div className="text-2xl font-bold text-yellow-600">{stats.practicing}</div>
                <div className="text-xs text-gray-600">Practicing</div>
              </div>
              <div>
                <div className="text-2xl font-bold text-green-600">{stats.completed}</div>
                <div className="text-xs text-gray-600">Completed</div>
              </div>
            </div>
          </div>

          <div className="flex items-center justify-between text-sm">
            <span className="text-gray-600">Scenario {currentIndex + 1} of {scenarios.length}</span>
            <span className="px-3 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-700">
              {currentScenario.accounting_topic}
            </span>
          </div>

          {currentStep === 'intro' && (
            <div className="space-y-4">
              <div className="bg-gradient-to-br from-blue-50 to-white border-2 border-blue-200 rounded-xl p-6">
                <h3 className="text-2xl font-bold text-gray-900 mb-3">
                  {currentScenario.scenario_title}
                </h3>
                <p className="text-gray-700 leading-relaxed mb-6">
                  {currentScenario.scenario_description}
                </p>

                <div className="grid md:grid-cols-2 gap-4 mb-6">
                  <div className="bg-white border border-blue-200 rounded-lg p-4">
                    <div className="text-sm font-semibold text-blue-700 mb-2">Your Role</div>
                    <div className="text-gray-900 font-medium">{currentScenario.consultant_role}</div>
                  </div>
                  <div className="bg-white border border-blue-200 rounded-lg p-4">
                    <div className="text-sm font-semibold text-blue-700 mb-2">Client Role</div>
                    <div className="text-gray-900 font-medium">{currentScenario.client_role}</div>
                  </div>
                </div>

                <div className="bg-white border border-blue-200 rounded-lg p-4">
                  <div className="text-sm font-semibold text-blue-700 mb-3">Key Vocabulary</div>
                  <div className="flex flex-wrap gap-2">
                    {keyVocab.map((term, idx) => (
                      <span
                        key={idx}
                        className="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-medium"
                      >
                        {term}
                      </span>
                    ))}
                  </div>
                </div>
              </div>
            </div>
          )}

          {currentStep === 'question1' && (
            <div className="space-y-4">
              <div className="bg-gradient-to-br from-purple-50 to-white border-2 border-purple-200 rounded-xl p-6">
                <div className="flex items-center gap-3 mb-4">
                  <MessageSquare className="w-6 h-6 text-purple-600" />
                  <div className="inline-block px-3 py-1 bg-purple-600 text-white text-sm font-medium rounded-full">
                    {currentScenario.client_role}
                  </div>
                </div>
                <p className="text-xl text-gray-900 leading-relaxed">
                  {currentScenario.step1_client_question}
                </p>
              </div>

              <div className="bg-white border-2 border-gray-200 rounded-xl p-6">
                <div className="text-sm font-semibold text-gray-700 mb-3">Your Task:</div>
                <p className="text-gray-700 mb-4">{currentScenario.step2_explanation_prompt}</p>
                <textarea
                  value={myAnswer1}
                  onChange={(e) => setMyAnswer1(e.target.value)}
                  placeholder="Type your explanation here... (optional)"
                  className="w-full h-32 px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                />
              </div>
            </div>
          )}

          {currentStep === 'answer1' && (
            <div className="space-y-4">
              <div className="bg-gradient-to-br from-green-50 to-white border-2 border-green-200 rounded-xl p-6">
                <div className="flex items-center gap-3 mb-4">
                  <Lightbulb className="w-6 h-6 text-green-600" />
                  <div className="inline-block px-3 py-1 bg-green-600 text-white text-sm font-medium rounded-full">
                    Model Answer
                  </div>
                </div>
                <p className="text-lg text-gray-900 leading-relaxed whitespace-pre-wrap">
                  {currentScenario.model_answer_step2}
                </p>
              </div>

              {myAnswer1 && (
                <div className="bg-white border-2 border-gray-200 rounded-xl p-6">
                  <div className="text-sm font-semibold text-gray-700 mb-3">Your Answer:</div>
                  <p className="text-gray-700 whitespace-pre-wrap">{myAnswer1}</p>
                </div>
              )}

              {currentScenario.japanese_hints && (
                <div className="bg-amber-50 border border-amber-200 rounded-lg p-4">
                  <div className="flex items-start gap-3">
                    <AlertCircle className="w-5 h-5 text-amber-600 mt-0.5 flex-shrink-0" />
                    <div>
                      <div className="text-sm font-semibold text-amber-900 mb-1">Japanese Hints:</div>
                      <p className="text-sm text-gray-700">{currentScenario.japanese_hints}</p>
                    </div>
                  </div>
                </div>
              )}
            </div>
          )}

          {currentStep === 'question2' && (
            <div className="space-y-4">
              <div className="bg-gradient-to-br from-purple-50 to-white border-2 border-purple-200 rounded-xl p-6">
                <div className="flex items-center gap-3 mb-4">
                  <MessageSquare className="w-6 h-6 text-purple-600" />
                  <div className="inline-block px-3 py-1 bg-purple-600 text-white text-sm font-medium rounded-full">
                    Follow-up Question
                  </div>
                </div>
                <p className="text-xl text-gray-900 leading-relaxed">
                  {currentScenario.step3_followup_question}
                </p>
              </div>

              <div className="bg-white border-2 border-gray-200 rounded-xl p-6">
                <div className="text-sm font-semibold text-gray-700 mb-3">Your Response:</div>
                <textarea
                  value={myAnswer2}
                  onChange={(e) => setMyAnswer2(e.target.value)}
                  placeholder="Type your response here... (optional)"
                  className="w-full h-32 px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                />
              </div>
            </div>
          )}

          {currentStep === 'answer2' && (
            <div className="space-y-4">
              <div className="bg-gradient-to-br from-green-50 to-white border-2 border-green-200 rounded-xl p-6">
                <div className="flex items-center gap-3 mb-4">
                  <Lightbulb className="w-6 h-6 text-green-600" />
                  <div className="inline-block px-3 py-1 bg-green-600 text-white text-sm font-medium rounded-full">
                    Model Answer
                  </div>
                </div>
                <p className="text-lg text-gray-900 leading-relaxed whitespace-pre-wrap">
                  {currentScenario.model_answer_step3}
                </p>
              </div>

              {myAnswer2 && (
                <div className="bg-white border-2 border-gray-200 rounded-xl p-6">
                  <div className="text-sm font-semibold text-gray-700 mb-3">Your Answer:</div>
                  <p className="text-gray-700 whitespace-pre-wrap">{myAnswer2}</p>
                </div>
              )}
            </div>
          )}

          {currentStep === 'complete' && (
            <div className="space-y-4">
              <div className="bg-gradient-to-br from-green-50 to-white border-2 border-green-200 rounded-xl p-8 text-center">
                <div className="text-6xl mb-4">✅</div>
                <h3 className="text-2xl font-bold text-gray-900 mb-2">Scenario Complete!</h3>
                <p className="text-gray-700 mb-6">
                  Great work on this roleplay. Mark your progress below.
                </p>
                <div className="flex gap-4 justify-center">
                  <button
                    onClick={() => handleStatusUpdate(false)}
                    className="px-6 py-3 bg-yellow-100 text-yellow-700 rounded-lg font-medium hover:bg-yellow-200 transition-colors"
                  >
                    Need More Practice
                  </button>
                  <button
                    onClick={() => handleStatusUpdate(true)}
                    className="px-6 py-3 bg-green-600 text-white rounded-lg font-medium hover:bg-green-700 transition-colors"
                  >
                    Mark Complete
                  </button>
                </div>
              </div>
            </div>
          )}

          <div className="flex items-center justify-between pt-4 border-t border-gray-200">
            <button
              onClick={goToPreviousScenario}
              disabled={currentIndex === 0}
              className="flex items-center gap-2 px-4 py-2 rounded-lg border-2 border-gray-300 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
            >
              <ChevronLeft className="w-5 h-5" />
              <span className="hidden sm:inline">Previous Scenario</span>
            </button>

            <div className="flex gap-2">
              <button
                onClick={handleStepBack}
                disabled={currentStep === 'intro'}
                className="px-4 py-2 rounded-lg border-2 border-blue-300 text-blue-700 hover:bg-blue-50 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
              >
                Back
              </button>
              <button
                onClick={handleStepNext}
                disabled={currentStep === 'complete'}
                className="px-6 py-2 rounded-lg bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors font-medium"
              >
                {currentStep === 'answer2' ? 'Complete' : 'Next'}
              </button>
            </div>

            <button
              onClick={goToNextScenario}
              disabled={currentIndex === scenarios.length - 1}
              className="flex items-center gap-2 px-4 py-2 rounded-lg border-2 border-gray-300 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
            >
              <span className="hidden sm:inline">Next Scenario</span>
              <ChevronRight className="w-5 h-5" />
            </button>
          </div>

          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
            <div className="flex items-start gap-3">
              <AlertCircle className="w-5 h-5 text-blue-600 mt-0.5 flex-shrink-0" />
              <div className="text-sm text-gray-700">
                <p className="font-medium mb-1">Purpose:</p>
                <p>
                  Practice explaining accounting treatments in professional English suitable for
                  Big4 FAAS work, client meetings, and cross-border transactions.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
