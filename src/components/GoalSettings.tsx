import { useState, useEffect } from 'react';
import { Target, Calendar, Save } from 'lucide-react';
import { updateStudyGoals } from '../lib/studyTimeService';
import { updateStudyPlan, STUDY_PLANS, type StudyPlan } from '../lib/studyPlanService';

interface GoalSettingsProps {
  currentWeeklyTarget?: number;
  currentExamDate?: string | null;
  currentStudyPlan?: string;
  onUpdate: () => void;
}

export function GoalSettings({ currentWeeklyTarget = 20, currentExamDate, currentStudyPlan = 'moderate', onUpdate }: GoalSettingsProps) {
  const [weeklyTarget, setWeeklyTarget] = useState(currentWeeklyTarget);
  const [examDate, setExamDate] = useState(currentExamDate || '');
  const [studyPlan, setStudyPlan] = useState<StudyPlan>(currentStudyPlan as StudyPlan);
  const [isSaving, setIsSaving] = useState(false);
  const [showSuccess, setShowSuccess] = useState(false);

  useEffect(() => {
    setWeeklyTarget(currentWeeklyTarget);
    setExamDate(currentExamDate || '');
    setStudyPlan((currentStudyPlan as StudyPlan) || 'moderate');
  }, [currentWeeklyTarget, currentExamDate, currentStudyPlan]);

  async function handleStudyPlanChange(plan: StudyPlan) {
    setIsSaving(true);
    try {
      await updateStudyPlan(plan);
      setStudyPlan(plan);
      setWeeklyTarget(STUDY_PLANS[plan].weeklyHours);
      setShowSuccess(true);
      setTimeout(() => setShowSuccess(false), 2000);
      onUpdate();
    } catch (error) {
      console.error('Error updating study plan:', error);
    } finally {
      setIsSaving(false);
    }
  }

  async function handleSave() {
    setIsSaving(true);
    try {
      await updateStudyGoals(weeklyTarget, examDate || undefined);
      setShowSuccess(true);
      setTimeout(() => setShowSuccess(false), 2000);
      onUpdate();
    } catch (error) {
      console.error('Error saving goals:', error);
    } finally {
      setIsSaving(false);
    }
  }

  const calculateEstimatedCompletion = () => {
    if (weeklyTarget <= 0) return null;
    const totalHours = 450;
    const weeksNeeded = totalHours / weeklyTarget;
    const completionDate = new Date();
    completionDate.setDate(completionDate.getDate() + weeksNeeded * 7);
    return completionDate;
  };

  const estimatedDate = calculateEstimatedCompletion();

  return (
    <div className="space-y-4">
      <div>
        <label className="block text-sm font-medium text-gray-700 mb-3 flex items-center gap-2">
          <Target className="w-4 h-4" />
          学習プラン
        </label>
        <div className="grid grid-cols-3 gap-2 mb-4">
          {(Object.keys(STUDY_PLANS) as StudyPlan[]).map((plan) => {
            const config = STUDY_PLANS[plan];
            const isSelected = studyPlan === plan;
            return (
              <button
                key={plan}
                onClick={() => handleStudyPlanChange(plan)}
                disabled={isSaving}
                className={`p-3 rounded-lg border-2 transition-all ${
                  isSelected
                    ? 'border-blue-600 bg-blue-50'
                    : 'border-gray-200 hover:border-blue-300'
                } disabled:opacity-50 disabled:cursor-not-allowed`}
              >
                <div className="text-sm font-medium text-gray-900">{config.name}</div>
                <div className="text-xs text-gray-600 mt-1">{config.duration}</div>
                <div className="text-xs font-semibold text-blue-600 mt-1">
                  週{config.weeklyHours}時間
                </div>
              </button>
            );
          })}
        </div>
        <div className="text-xs text-gray-600">
          1日のタスク数が自動計算されます
        </div>
      </div>

      <div>
        <label className="block text-sm font-medium text-gray-700 mb-2 flex items-center gap-2">
          <Target className="w-4 h-4" />
          週の学習時間目標（カスタム）
        </label>
        <input
          type="number"
          min="1"
          max="70"
          step="0.5"
          value={weeklyTarget}
          onChange={(e) => setWeeklyTarget(Number(e.target.value))}
          className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
        />
        <div className="mt-2 text-xs text-gray-600 space-y-1">
          <p>現在の目標: {weeklyTarget}時間/週</p>
          {estimatedDate && (
            <p className="text-gray-500">
              このペースで450時間達成まで約{' '}
              <span className="font-medium text-gray-900">
                {Math.ceil((450 / weeklyTarget) * 7)} 日
              </span>
              {' '}（{estimatedDate.toLocaleDateString('ja-JP')} 頃）
            </p>
          )}
        </div>
      </div>

      <div>
        <label className="block text-sm font-medium text-gray-700 mb-2 flex items-center gap-2">
          <Calendar className="w-4 h-4" />
          目標試験日
        </label>
        <input
          type="date"
          value={examDate}
          onChange={(e) => setExamDate(e.target.value)}
          className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
        />
        {examDate && (
          <div className="mt-2 text-xs text-gray-600">
            試験まで{' '}
            <span className="font-medium text-gray-900">
              {Math.ceil((new Date(examDate).getTime() - new Date().getTime()) / (1000 * 60 * 60 * 24))}
            </span>
            {' '}日
          </div>
        )}
      </div>

      <button
        onClick={handleSave}
        disabled={isSaving}
        className="w-full flex items-center justify-center gap-2 px-4 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors font-medium disabled:opacity-50 disabled:cursor-not-allowed"
      >
        {isSaving ? (
          <>
            <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
            保存中...
          </>
        ) : showSuccess ? (
          <>
            <Save className="w-4 h-4" />
            保存しました
          </>
        ) : (
          <>
            <Save className="w-4 h-4" />
            カスタム目標を保存
          </>
        )}
      </button>
    </div>
  );
}
