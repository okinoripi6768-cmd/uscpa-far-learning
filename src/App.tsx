import { useEffect, useState } from 'react';
import { Calendar, Target, Settings as SettingsIcon, Home, BarChart3, Clock, BookOpen, MessageSquare, Zap } from 'lucide-react';
import { TaskCard } from './components/TaskCard';
import { SettingsPanel } from './components/SettingsPanel';
import { ProgressView } from './components/ProgressView';
import { StudyTimeDashboard } from './components/StudyTimeDashboard';
import { NotesReview } from './components/NotesReview';
import { FlashcardReview } from './components/FlashcardReview';
import { RoleplayPractice } from './components/RoleplayPractice';
import { InstantTranslation } from './components/InstantTranslation';
import { PasswordProtection } from './components/PasswordProtection';
import { getTodaysTasks, getUserSettings, completeTask, updateUserSettings, resetProgress, getTodaysCompletedCount, getOverallProgress, getWeeklyStats, getAllChapters } from './lib/taskService';
import { getFlashcardStats } from './lib/flashcardService';
import { getRoleplayStats } from './lib/roleplayService';
import { getInstantTranslationStats } from './lib/instantTranslationService';
import type { DailyTask, TaskResult, UserSettings, OverallProgress, Chapter } from './lib/types';

type ViewMode = 'today' | 'progress' | 'studytime';

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  if (!isAuthenticated) {
    return <PasswordProtection onAuthenticated={() => setIsAuthenticated(true)} />;
  }
  const [tasks, setTasks] = useState<DailyTask[]>([]);
  const [settings, setSettings] = useState<UserSettings | null>(null);
  const [currentTaskIndex, setCurrentTaskIndex] = useState(0);
  const [isProcessing, setIsProcessing] = useState(false);
  const [showSettings, setShowSettings] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const [viewMode, setViewMode] = useState<ViewMode>('today');
  const [todaysCompletedCount, setTodaysCompletedCount] = useState(0);
  const [overallProgress, setOverallProgress] = useState<OverallProgress>({ completed: 0, total: 0, percentage: 0 });
  const [weeklyStats, setWeeklyStats] = useState({ weeklyTarget: 0, weeklyCompleted: 0, dailyTarget: 0 });
  const [showFlashcards, setShowFlashcards] = useState(false);
  const [flashcardStats, setFlashcardStats] = useState({ total: 0, notStarted: 0, reviewing: 0, mastered: 0 });
  const [allChapters, setAllChapters] = useState<Chapter[]>([]);
  const [selectedFlashcardChapters, setSelectedFlashcardChapters] = useState<string[]>([]);
  const [showRoleplay, setShowRoleplay] = useState(false);
  const [roleplayStats, setRoleplayStats] = useState({ total: 0, notStarted: 0, practicing: 0, completed: 0, completionRate: 0 });
  const [selectedRoleplayChapters, setSelectedRoleplayChapters] = useState<string[]>([]);
  const [showInstantTranslation, setShowInstantTranslation] = useState(false);
  const [instantTranslationStats, setInstantTranslationStats] = useState({ total: 0, notStarted: 0, practicing: 0, mastered: 0, completionRate: 0 });
  const [selectedInstantTranslationChapters, setSelectedInstantTranslationChapters] = useState<string[]>([]);

  useEffect(() => {
    loadData();
  }, []);

  async function loadData() {
    setIsLoading(true);
    try {
      const [tasksData, settingsData, completedCount, progress, weekly, chapters] = await Promise.all([
        getTodaysTasks(),
        getUserSettings(),
        getTodaysCompletedCount(),
        getOverallProgress(),
        getWeeklyStats(),
        getAllChapters(),
      ]);
      setTasks(tasksData);
      setSettings(settingsData);
      setTodaysCompletedCount(completedCount);
      setOverallProgress(progress);
      setWeeklyStats(weekly);
      setAllChapters(chapters);

      const excludedChapters = (settingsData?.excluded_chapters as string[]) || [];
      const availableChapters = chapters.filter(c => !excludedChapters.includes(c.id)).map(c => c.id);
      setSelectedFlashcardChapters(availableChapters);
      setSelectedRoleplayChapters(availableChapters);
      setSelectedInstantTranslationChapters(availableChapters);

      if (availableChapters.length > 0) {
        const [flashcardData, roleplayData, instantTranslationData] = await Promise.all([
          getFlashcardStats(availableChapters),
          getRoleplayStats(availableChapters[0]),
          getInstantTranslationStats(availableChapters[0])
        ]);
        setFlashcardStats(flashcardData);
        setRoleplayStats(roleplayData);
        setInstantTranslationStats(instantTranslationData);
      }
    } catch (error) {
      console.error('Error loading data:', error);
    } finally {
      setIsLoading(false);
    }
  }

  async function handleTaskComplete(result: TaskResult | null, notes?: string) {
    if (!settings) return;

    const currentTask = tasks[currentTaskIndex];
    if (!currentTask) return;

    setIsProcessing(true);
    try {
      await completeTask(currentTask.task.id, result, settings.current_round, notes);

      const [tasksData, newCompletedCount, weekly, progress] = await Promise.all([
        getTodaysTasks(),
        getTodaysCompletedCount(),
        getWeeklyStats(),
        getOverallProgress(),
      ]);

      setTasks(tasksData);
      setTodaysCompletedCount(newCompletedCount);
      setWeeklyStats(weekly);
      setOverallProgress(progress);
      setCurrentTaskIndex(0);
    } catch (error) {
      console.error('Error completing task:', error);
    } finally {
      setIsProcessing(false);
    }
  }

  async function handleUpdateRound(round: number) {
    try {
      await updateUserSettings({ current_round: round });
      await loadData();
      setCurrentTaskIndex(0);
    } catch (error) {
      console.error('Error updating round:', error);
    }
  }

  async function handleUpdateLimit(limit: number) {
    try {
      await updateUserSettings({
        daily_task_limit: limit,
        original_daily_task_limit: limit
      });
      await loadData();
    } catch (error) {
      console.error('Error updating limit:', error);
    }
  }

  async function handleUpdateChapters(excludedChapters: string[]) {
    try {
      await updateUserSettings({ excluded_chapters: excludedChapters });
      await loadData();
      setCurrentTaskIndex(0);
    } catch (error) {
      console.error('Error updating chapters:', error);
    }
  }

  async function handleReset() {
    try {
      await resetProgress();
      await loadData();
      setCurrentTaskIndex(0);
    } catch (error) {
      console.error('Error resetting progress:', error);
    }
  }

  async function handleFlashcardChapterToggle(chapterId: string) {
    const newSelection = selectedFlashcardChapters.includes(chapterId)
      ? selectedFlashcardChapters.filter(id => id !== chapterId)
      : [...selectedFlashcardChapters, chapterId];

    setSelectedFlashcardChapters(newSelection);

    if (newSelection.length > 0) {
      const flashcardData = await getFlashcardStats(newSelection);
      setFlashcardStats(flashcardData);
    } else {
      setFlashcardStats({ total: 0, notStarted: 0, reviewing: 0, mastered: 0 });
    }
  }

  async function handleRoleplayChapterSelect(chapterId: string) {
    setSelectedRoleplayChapters([chapterId]);
    const stats = await getRoleplayStats(chapterId);
    setRoleplayStats(stats);
  }

  async function handleInstantTranslationChapterSelect(chapterId: string) {
    setSelectedInstantTranslationChapters([chapterId]);
    const stats = await getInstantTranslationStats(chapterId);
    setInstantTranslationStats(stats);
  }

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-gray-100 flex items-center justify-center">
        <div className="text-gray-600">読み込み中...</div>
      </div>
    );
  }

  const reviewTasks = tasks.filter(t => t.isPriority);
  const newTasks = tasks.filter(t => !t.isPriority);
  const currentTask = tasks[currentTaskIndex];
  const totalToday = tasks.length;

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-gray-100">
      <div className="max-w-2xl mx-auto px-3 sm:px-4 py-4 sm:py-6 pb-safe">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-2xl font-bold text-gray-900 mb-1">
              FAR 学習管理
            </h1>
            <div className="flex items-center gap-4 text-sm text-gray-600">
              <div className="flex items-center gap-1">
                <Calendar className="w-4 h-4" />
                <span>{new Date().toLocaleDateString('ja-JP')}</span>
              </div>
              <div className="flex items-center gap-1">
                <Target className="w-4 h-4" />
                <span>Round {settings?.current_round || 1}</span>
              </div>
              <div className="flex items-center gap-1">
                <BarChart3 className="w-4 h-4" />
                <span>全体 {overallProgress.percentage}%</span>
              </div>
            </div>
          </div>
          <button
            onClick={() => setShowSettings(!showSettings)}
            className="p-2 text-gray-600 hover:bg-white rounded-lg transition-colors"
          >
            <SettingsIcon className="w-6 h-6" />
          </button>
        </div>

        {showSettings && (
          <SettingsPanel
            settings={settings}
            onUpdateRound={handleUpdateRound}
            onUpdateLimit={handleUpdateLimit}
            onUpdateChapters={handleUpdateChapters}
            onReset={handleReset}
          />
        )}

        <div className="bg-white rounded-lg shadow-md mb-4 flex">
          <button
            onClick={() => setViewMode('today')}
            className={`flex-1 py-3 px-4 font-medium transition-colors flex items-center justify-center gap-2 ${
              viewMode === 'today'
                ? 'text-blue-600 border-b-2 border-blue-600'
                : 'text-gray-600 hover:text-gray-900'
            }`}
          >
            <Home className="w-4 h-4" />
            今日のタスク
          </button>
          <button
            onClick={() => setViewMode('progress')}
            className={`flex-1 py-3 px-4 font-medium transition-colors flex items-center justify-center gap-2 ${
              viewMode === 'progress'
                ? 'text-blue-600 border-b-2 border-blue-600'
                : 'text-gray-600 hover:text-gray-900'
            }`}
          >
            <BarChart3 className="w-4 h-4" />
            全体進捗
          </button>
          <button
            onClick={() => setViewMode('studytime')}
            className={`flex-1 py-3 px-4 font-medium transition-colors flex items-center justify-center gap-2 ${
              viewMode === 'studytime'
                ? 'text-blue-600 border-b-2 border-blue-600'
                : 'text-gray-600 hover:text-gray-900'
            }`}
          >
            <Clock className="w-4 h-4" />
            学習時間
          </button>
        </div>

        {viewMode === 'today' ? (
          <>
            <div className="bg-white rounded-lg shadow-md p-4 mb-6">
              <div className="grid grid-cols-2 gap-4 mb-4">
                <div className="bg-blue-50 rounded-lg p-3">
                  <div className="text-xs text-gray-600 mb-1">今日の進捗</div>
                  <div className="text-2xl font-bold text-blue-600">
                    {todaysCompletedCount} <span className="text-base text-gray-500">/ {weeklyStats.dailyTarget}</span>
                  </div>
                  <div className="text-xs text-gray-500 mt-1">
                    未完了 {totalToday} タスク
                  </div>
                </div>

                <div className="bg-green-50 rounded-lg p-3">
                  <div className="text-xs text-gray-600 mb-1">今週の進捗</div>
                  <div className="text-2xl font-bold text-green-600">
                    {weeklyStats.weeklyCompleted} <span className="text-base text-gray-500">/ {weeklyStats.weeklyTarget}</span>
                  </div>
                  <div className="text-xs text-gray-500 mt-1">
                    {weeklyStats.weeklyTarget > 0
                      ? `${Math.round((weeklyStats.weeklyCompleted / weeklyStats.weeklyTarget) * 100)}%`
                      : '0%'
                    }
                  </div>
                </div>
              </div>

              <div className="text-xs text-gray-500 mb-3">
                復習: {reviewTasks.length} / 新規: {newTasks.length}
              </div>

              <div className="border-t pt-3">
                <div className="text-sm text-gray-600 mb-2">Round 5まで全体進捗</div>
                <div className="flex items-center gap-3">
                  <div className="flex-1 bg-gray-200 rounded-full h-2">
                    <div
                      className="bg-blue-600 h-2 rounded-full transition-all duration-300"
                      style={{ width: `${overallProgress.percentage}%` }}
                    />
                  </div>
                  <div className="text-sm font-semibold text-gray-900">
                    {overallProgress.percentage}%
                  </div>
                </div>
                <div className="text-xs text-gray-500 mt-1">
                  {overallProgress.completed} / {overallProgress.total} タスク完了
                </div>
              </div>
            </div>

            <NotesReview />

            {currentTask ? (
              <>
                <div className="bg-gradient-to-r from-sky-50 to-blue-50 rounded-lg p-4 mb-2 border-2 border-sky-200">
                  <h2 className="text-lg font-bold text-gray-900 flex items-center gap-2">
                    <span className="bg-sky-600 text-white text-sm font-bold px-3 py-1 rounded-full">Section 1</span>
                    MC Progress Tracking
                  </h2>
                </div>
                <TaskCard
                  dailyTask={currentTask}
                  onComplete={handleTaskComplete}
                  isProcessing={isProcessing}
                />
              </>
            ) : (
              <div className="bg-white rounded-lg shadow-md p-8 text-center mb-6">
                <div className="text-6xl mb-4">🎉</div>
                <h2 className="text-xl font-bold text-gray-900 mb-2">
                  今日のタスク完了！
                </h2>
                <p className="text-gray-600">
                  素晴らしい進捗です。明日も頑張りましょう。
                </p>
              </div>
            )}

            <div className="bg-gradient-to-r from-blue-50 to-indigo-50 rounded-lg p-4 mb-6 border-2 border-blue-200">
              <h2 className="text-lg font-bold text-gray-900 mb-2 flex items-center gap-2">
                <span className="bg-blue-600 text-white text-sm font-bold px-3 py-1 rounded-full">Section 2</span>
                MC Tips Flashcards
              </h2>
              <p className="text-sm text-gray-600 mb-4">
                Short tips and traps related to MC questions - key accounting reminders and exam-oriented insights
              </p>

              <div className="bg-white rounded-lg shadow-md p-4">
                <div className="flex items-center justify-between mb-3">
                  <div className="flex items-center gap-2">
                    <BookOpen className="w-5 h-5 text-blue-600" />
                    <h3 className="font-semibold text-gray-900">FAR 英語フラッシュカード</h3>
                  </div>
                </div>

              <div className="mb-3">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  学習するChapter
                </label>
                <div className="max-h-40 overflow-y-auto border border-gray-200 rounded-lg p-2 space-y-1">
                  {allChapters.map((chapter) => {
                    const isSelected = selectedFlashcardChapters.includes(chapter.id);
                    return (
                      <label
                        key={chapter.id}
                        className="flex items-center gap-2 p-2 rounded hover:bg-gray-50 cursor-pointer"
                      >
                        <input
                          type="checkbox"
                          checked={isSelected}
                          onChange={() => handleFlashcardChapterToggle(chapter.id)}
                          className="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-2 focus:ring-blue-500"
                        />
                        <span className={`text-sm ${isSelected ? 'text-gray-900 font-medium' : 'text-gray-500'}`}>
                          {chapter.title}
                        </span>
                      </label>
                    );
                  })}
                </div>
              </div>

              <div className="grid grid-cols-4 gap-2 mb-3">
                <div className="text-center p-2 bg-gray-50 rounded">
                  <div className="text-lg font-bold text-gray-900">{flashcardStats.total}</div>
                  <div className="text-xs text-gray-600">総数</div>
                </div>
                <div className="text-center p-2 bg-blue-50 rounded">
                  <div className="text-lg font-bold text-blue-600">{flashcardStats.notStarted}</div>
                  <div className="text-xs text-gray-600">未学習</div>
                </div>
                <div className="text-center p-2 bg-yellow-50 rounded">
                  <div className="text-lg font-bold text-yellow-600">{flashcardStats.reviewing}</div>
                  <div className="text-xs text-gray-600">復習中</div>
                </div>
                <div className="text-center p-2 bg-green-50 rounded">
                  <div className="text-lg font-bold text-green-600">{flashcardStats.mastered}</div>
                  <div className="text-xs text-gray-600">習得済</div>
                </div>
              </div>

                <button
                  onClick={() => setShowFlashcards(true)}
                  className="w-full py-3 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition-colors flex items-center justify-center gap-2 disabled:bg-gray-400 disabled:cursor-not-allowed"
                  disabled={selectedFlashcardChapters.length === 0}
                >
                  <BookOpen className="w-5 h-5" />
                  フラッシュカードを学習する
                </button>
                {selectedFlashcardChapters.length === 0 && (
                  <p className="text-xs text-red-600 text-center mt-2">
                    上記のリストからChapterを選択してください
                  </p>
                )}
              </div>
            </div>

            {showFlashcards && (
              <FlashcardReview
                selectedChapterIds={selectedFlashcardChapters}
                onClose={() => {
                  setShowFlashcards(false);
                  loadData();
                }}
              />
            )}

            <div className="bg-gradient-to-r from-green-50 to-emerald-50 rounded-lg p-4 mb-6 border-2 border-green-200">
              <h2 className="text-lg font-bold text-gray-900 mb-2 flex items-center gap-2">
                <span className="bg-green-600 text-white text-sm font-bold px-3 py-1 rounded-full">Section 3</span>
                FAAS ロールプレイ練習
              </h2>
              <p className="text-sm text-gray-600 mb-4">
                Big4 FAAS実務シミュレーション - クライアントミーティングでの会計説明練習
              </p>

              <div className="bg-white rounded-lg shadow-md p-4">
                <div className="flex items-center justify-between mb-3">
                  <div className="flex items-center gap-2">
                    <MessageSquare className="w-5 h-5 text-green-600" />
                    <h3 className="font-semibold text-gray-900">Roleplay Scenarios</h3>
                  </div>
                </div>

                <div className="mb-3">
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    学習するChapter
                  </label>
                  <select
                    value={selectedRoleplayChapters[0] || ''}
                    onChange={(e) => handleRoleplayChapterSelect(e.target.value)}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500"
                  >
                    <option value="">選択してください</option>
                    {allChapters.map((chapter) => (
                      <option key={chapter.id} value={chapter.id}>
                        {chapter.title}
                      </option>
                    ))}
                  </select>
                </div>

                <div className="grid grid-cols-4 gap-2 mb-3">
                  <div className="text-center p-2 bg-gray-50 rounded">
                    <div className="text-lg font-bold text-gray-900">{roleplayStats.total}</div>
                    <div className="text-xs text-gray-600">総数</div>
                  </div>
                  <div className="text-center p-2 bg-blue-50 rounded">
                    <div className="text-lg font-bold text-blue-600">{roleplayStats.notStarted}</div>
                    <div className="text-xs text-gray-600">未開始</div>
                  </div>
                  <div className="text-center p-2 bg-yellow-50 rounded">
                    <div className="text-lg font-bold text-yellow-600">{roleplayStats.practicing}</div>
                    <div className="text-xs text-gray-600">練習中</div>
                  </div>
                  <div className="text-center p-2 bg-green-50 rounded">
                    <div className="text-lg font-bold text-green-600">{roleplayStats.completed}</div>
                    <div className="text-xs text-gray-600">完了</div>
                  </div>
                </div>

                <div className="mb-3 bg-amber-50 border border-amber-200 rounded-lg p-3">
                  <p className="text-xs text-gray-700">
                    <strong>Focus:</strong> Explaining accounting treatments in Big4 FAAS style - client meetings, technical discussions
                  </p>
                </div>

                <button
                  onClick={() => setShowRoleplay(true)}
                  className="w-full py-3 bg-green-600 hover:bg-green-700 text-white font-medium rounded-lg transition-colors flex items-center justify-center gap-2 disabled:bg-gray-400 disabled:cursor-not-allowed"
                  disabled={selectedRoleplayChapters.length === 0}
                >
                  <MessageSquare className="w-5 h-5" />
                  ロールプレイを開始
                </button>
                {selectedRoleplayChapters.length === 0 && (
                  <p className="text-xs text-red-600 text-center mt-2">
                    上記からChapterを選択してください
                  </p>
                )}
              </div>
            </div>

            {showRoleplay && selectedRoleplayChapters[0] && (
              <RoleplayPractice
                chapterId={selectedRoleplayChapters[0]}
                onClose={() => {
                  setShowRoleplay(false);
                  if (selectedRoleplayChapters[0]) {
                    handleRoleplayChapterSelect(selectedRoleplayChapters[0]);
                  }
                }}
              />
            )}

            <div className="bg-gradient-to-r from-purple-50 to-fuchsia-50 rounded-lg p-4 mb-6 border-2 border-purple-200">
              <h2 className="text-lg font-bold text-gray-900 mb-2 flex items-center gap-2">
                <span className="bg-purple-600 text-white text-sm font-bold px-3 py-1 rounded-full">Section 4</span>
                瞬間英作文練習
              </h2>
              <p className="text-sm text-gray-600 mb-4">
                日本語→英語の瞬間英作文 - 会計用語と短いフレーズの練習
              </p>

              <div className="bg-white rounded-lg shadow-md p-4">
                <div className="flex items-center justify-between mb-3">
                  <div className="flex items-center gap-2">
                    <Zap className="w-5 h-5 text-purple-600" />
                    <h3 className="font-semibold text-gray-900">Instant Translation</h3>
                  </div>
                </div>

                <div className="mb-3">
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    学習するChapter
                  </label>
                  <select
                    value={selectedInstantTranslationChapters[0] || ''}
                    onChange={(e) => handleInstantTranslationChapterSelect(e.target.value)}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                  >
                    <option value="">選択してください</option>
                    {allChapters.map((chapter) => (
                      <option key={chapter.id} value={chapter.id}>
                        {chapter.title}
                      </option>
                    ))}
                  </select>
                </div>

                <div className="grid grid-cols-4 gap-2 mb-3">
                  <div className="text-center p-2 bg-gray-50 rounded">
                    <div className="text-lg font-bold text-gray-900">{instantTranslationStats.total}</div>
                    <div className="text-xs text-gray-600">総数</div>
                  </div>
                  <div className="text-center p-2 bg-blue-50 rounded">
                    <div className="text-lg font-bold text-blue-600">{instantTranslationStats.notStarted}</div>
                    <div className="text-xs text-gray-600">未開始</div>
                  </div>
                  <div className="text-center p-2 bg-yellow-50 rounded">
                    <div className="text-lg font-bold text-yellow-600">{instantTranslationStats.practicing}</div>
                    <div className="text-xs text-gray-600">練習中</div>
                  </div>
                  <div className="text-center p-2 bg-green-50 rounded">
                    <div className="text-lg font-bold text-green-600">{instantTranslationStats.mastered}</div>
                    <div className="text-xs text-gray-600">習得済</div>
                  </div>
                </div>

                <div className="mb-3 bg-purple-50 border border-purple-200 rounded-lg p-3">
                  <p className="text-xs text-gray-700">
                    <strong>練習方法:</strong> 日本語を見て、すぐに英語で言えるように練習します。
                    短い文章で会計用語を自然に使えるようになります。
                  </p>
                </div>

                <button
                  onClick={() => setShowInstantTranslation(true)}
                  className="w-full py-3 bg-purple-600 hover:bg-purple-700 text-white font-medium rounded-lg transition-colors flex items-center justify-center gap-2 disabled:bg-gray-400 disabled:cursor-not-allowed"
                  disabled={selectedInstantTranslationChapters.length === 0}
                >
                  <Zap className="w-5 h-5" />
                  瞬間英作文を練習する
                </button>
                {selectedInstantTranslationChapters.length === 0 && (
                  <p className="text-xs text-red-600 text-center mt-2">
                    上記からChapterを選択してください
                  </p>
                )}
              </div>
            </div>

            {showInstantTranslation && selectedInstantTranslationChapters[0] && (
              <InstantTranslation
                chapterId={selectedInstantTranslationChapters[0]}
                onClose={() => {
                  setShowInstantTranslation(false);
                  if (selectedInstantTranslationChapters[0]) {
                    handleInstantTranslationChapterSelect(selectedInstantTranslationChapters[0]);
                  }
                }}
              />
            )}
          </>
        ) : viewMode === 'progress' ? (
          <ProgressView settings={settings} />
        ) : (
          <StudyTimeDashboard />
        )}
      </div>
    </div>
  );
}

export default App;
