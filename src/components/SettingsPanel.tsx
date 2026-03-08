import { Settings, RefreshCw, BookOpen } from 'lucide-react';
import { useState, useEffect } from 'react';
import type { UserSettings, Chapter } from '../lib/types';
import { getAllChapters } from '../lib/taskService';
import { GoalSettings } from './GoalSettings';

interface SettingsPanelProps {
  settings: UserSettings | null;
  onUpdateRound: (round: number) => void;
  onUpdateLimit: (limit: number) => void;
  onUpdateChapters: (excludedChapters: string[]) => void;
  onReset: () => void;
}

export function SettingsPanel({ settings, onUpdateRound, onUpdateLimit, onUpdateChapters, onReset }: SettingsPanelProps) {
  const [showResetConfirm, setShowResetConfirm] = useState(false);
  const [chapters, setChapters] = useState<Chapter[]>([]);
  const [excludedChapters, setExcludedChapters] = useState<string[]>([]);

  useEffect(() => {
    loadChapters();
  }, []);

  useEffect(() => {
    if (settings?.excluded_chapters) {
      setExcludedChapters((settings.excluded_chapters as string[]) || []);
    }
  }, [settings]);

  async function loadChapters() {
    const data = await getAllChapters();
    setChapters(data);
  }

  if (!settings) return null;

  const handleReset = () => {
    onReset();
    setShowResetConfirm(false);
  };

  const handleChapterToggle = (chapterId: string) => {
    const newExcluded = excludedChapters.includes(chapterId)
      ? excludedChapters.filter(id => id !== chapterId)
      : [...excludedChapters, chapterId];

    setExcludedChapters(newExcluded);
    onUpdateChapters(newExcluded);
  };

  return (
    <div className="bg-white rounded-lg shadow-md p-6 mb-4">
      <div className="flex items-center gap-2 mb-4">
        <Settings className="w-5 h-5 text-gray-700" />
        <h2 className="text-lg font-semibold text-gray-900">学習設定</h2>
      </div>

      <div className="space-y-4">
        <div className="pb-4 border-b border-gray-200">
          <h3 className="text-sm font-semibold text-gray-900 mb-3">学習目標</h3>
          <GoalSettings
            currentWeeklyTarget={settings.weekly_study_hours_target}
            currentExamDate={settings.target_exam_date}
            currentStudyPlan={settings.study_plan}
            onUpdate={() => window.location.reload()}
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-2">
            現在のラウンド
          </label>
          <select
            value={settings.current_round}
            onChange={(e) => onUpdateRound(Number(e.target.value))}
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          >
            <option value={1}>Round 1 - 講義視聴</option>
            <option value={2}>Round 2 - MC演習</option>
            <option value={3}>Round 3 - MC再演習</option>
            <option value={4}>Round 4 - TBS解放</option>
          </select>
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-2">
            1日のタスク上限（自動計算）
          </label>
          <div className="bg-gray-50 rounded-lg p-4 border border-gray-200">
            <div className="text-2xl font-bold text-blue-600 mb-2">
              {settings.daily_task_limit} タスク
            </div>
            <div className="text-xs text-gray-600 space-y-1">
              <p>学習プランに基づいて自動計算されています</p>
              <p>元の設定: {settings.original_daily_task_limit}タスク</p>
              {settings.daily_task_limit < settings.original_daily_task_limit && (
                <p className="text-orange-600 font-medium">
                  完了できなかった日があるため、上限が自動調整されています
                </p>
              )}
              <p className="text-gray-500">
                連続3日完了すると自動で上限が1タスクずつ増えます
              </p>
            </div>
          </div>
        </div>

        <div>
          <div className="flex items-center gap-2 mb-2">
            <BookOpen className="w-4 h-4 text-gray-700" />
            <label className="block text-sm font-medium text-gray-700">
              学習するChapter
            </label>
          </div>
          <div className="max-h-64 overflow-y-auto border border-gray-200 rounded-lg p-3 space-y-2">
            {chapters.map((chapter) => {
              const isIncluded = !excludedChapters.includes(chapter.id);
              return (
                <label
                  key={chapter.id}
                  className="flex items-center gap-3 p-2 rounded hover:bg-gray-50 cursor-pointer"
                >
                  <input
                    type="checkbox"
                    checked={isIncluded}
                    onChange={() => handleChapterToggle(chapter.id)}
                    className="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-2 focus:ring-blue-500"
                  />
                  <span className={`text-sm ${isIncluded ? 'text-gray-900' : 'text-gray-400 line-through'}`}>
                    {chapter.title}
                  </span>
                </label>
              );
            })}
          </div>
          <p className="mt-2 text-xs text-gray-500">
            チェックを外したChapterはタスクから除外されます
          </p>
        </div>

        <div className="pt-4 border-t border-gray-200">
          <div className="text-sm text-gray-600 space-y-1 mb-4">
            <div className="flex justify-between">
              <span>Round 1 開始日:</span>
              <span className="font-medium">{settings.round_1_start_date}</span>
            </div>
            {settings.round_2_start_date && (
              <div className="flex justify-between">
                <span>Round 2 開始日:</span>
                <span className="font-medium">{settings.round_2_start_date}</span>
              </div>
            )}
            {settings.round_3_start_date && (
              <div className="flex justify-between">
                <span>Round 3 開始日:</span>
                <span className="font-medium">{settings.round_3_start_date}</span>
              </div>
            )}
            {settings.round_4_start_date && (
              <div className="flex justify-between">
                <span>Round 4 開始日:</span>
                <span className="font-medium">{settings.round_4_start_date}</span>
              </div>
            )}
          </div>

          {!showResetConfirm ? (
            <button
              onClick={() => setShowResetConfirm(true)}
              className="w-full flex items-center justify-center gap-2 px-4 py-3 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-colors font-medium"
            >
              <RefreshCw className="w-4 h-4" />
              進捗をリセット
            </button>
          ) : (
            <div className="space-y-2">
              <p className="text-sm text-red-600 font-medium text-center">
                全ての学習進捗が削除されます
              </p>
              <div className="flex gap-2">
                <button
                  onClick={() => setShowResetConfirm(false)}
                  className="flex-1 px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition-colors"
                >
                  キャンセル
                </button>
                <button
                  onClick={handleReset}
                  className="flex-1 px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors font-medium"
                >
                  リセット実行
                </button>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
