import { useEffect, useState } from 'react';
import { Clock, Target, TrendingUp, Calendar, AlertCircle, CheckCircle } from 'lucide-react';
import { getStudyTimeStats, getStudyHistory } from '../lib/studyTimeService';
import type { StudyTimeStats } from '../lib/studyTimeService';

export function StudyTimeDashboard() {
  const [stats, setStats] = useState<StudyTimeStats | null>(null);
  const [history, setHistory] = useState<Array<{ date: string; minutes: number }>>([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    loadData();
  }, []);

  async function loadData() {
    setIsLoading(true);
    try {
      const [statsData, historyData] = await Promise.all([
        getStudyTimeStats(),
        getStudyHistory(14),
      ]);
      setStats(statsData);
      setHistory(historyData);
    } catch (error) {
      console.error('Error loading study time data:', error);
    } finally {
      setIsLoading(false);
    }
  }

  if (isLoading || !stats) {
    return (
      <div className="flex items-center justify-center py-8">
        <div className="text-gray-600">読み込み中...</div>
      </div>
    );
  }

  const totalRequiredHours = 450;
  const progressPercentage = (stats.totalHours / totalRequiredHours) * 100;
  const remainingHours = totalRequiredHours - stats.totalHours;

  return (
    <div className="space-y-4">
      <div className="bg-white rounded-lg shadow-md p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4 flex items-center gap-2">
          <Clock className="w-5 h-5" />
          学習時間サマリー
        </h2>

        <div className="mb-6">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-gray-600">合格までの進捗</span>
            <span className="text-sm font-medium text-gray-900">
              {stats.totalHours.toFixed(1)}h / {totalRequiredHours}h
            </span>
          </div>
          <div className="w-full bg-gray-200 rounded-full h-3">
            <div
              className="bg-gradient-to-r from-blue-500 to-blue-600 h-3 rounded-full transition-all"
              style={{ width: `${Math.min(progressPercentage, 100)}%` }}
            />
          </div>
          <div className="mt-1 text-xs text-gray-500">
            {progressPercentage.toFixed(1)}% 完了 · あと {remainingHours.toFixed(1)}時間
          </div>
        </div>

        <div className="grid grid-cols-2 gap-4">
          <div className="bg-blue-50 rounded-lg p-4">
            <div className="flex items-center gap-2 mb-1">
              <TrendingUp className="w-4 h-4 text-blue-600" />
              <div className="text-sm text-gray-600">今週の学習時間</div>
            </div>
            <div className="text-2xl font-bold text-blue-600">
              {stats.weeklyHours.toFixed(1)}h
            </div>
            <div className="mt-1 flex items-center gap-1">
              <div className="w-full bg-blue-200 rounded-full h-1.5">
                <div
                  className="bg-blue-600 h-1.5 rounded-full"
                  style={{ width: `${Math.min(stats.weeklyProgress, 100)}%` }}
                />
              </div>
              <span className="text-xs text-gray-600 whitespace-nowrap">
                {stats.weeklyProgress.toFixed(0)}%
              </span>
            </div>
            <div className="mt-1 text-xs text-gray-500">
              目標: {stats.targetWeeklyHours}h/週
            </div>
          </div>

          <div className="bg-green-50 rounded-lg p-4">
            <div className="flex items-center gap-2 mb-1">
              <Calendar className="w-4 h-4 text-green-600" />
              <div className="text-sm text-gray-600">平均/日</div>
            </div>
            <div className="text-2xl font-bold text-green-600">
              {(stats.averagePerDay / 60).toFixed(1)}h
            </div>
            <div className="mt-2 text-xs text-gray-500">
              学習日数: {stats.daysStudied}日
            </div>
          </div>
        </div>
      </div>

      {stats.daysUntilExam !== null && (
        <div className={`rounded-lg shadow-md p-6 ${stats.onTrack ? 'bg-green-50' : 'bg-orange-50'}`}>
          <div className="flex items-start gap-3">
            {stats.onTrack ? (
              <CheckCircle className="w-5 h-5 text-green-600 mt-0.5" />
            ) : (
              <AlertCircle className="w-5 h-5 text-orange-600 mt-0.5" />
            )}
            <div className="flex-1">
              <h3 className={`font-semibold mb-2 ${stats.onTrack ? 'text-green-900' : 'text-orange-900'}`}>
                試験日までの目標
              </h3>
              <div className="space-y-2 text-sm">
                <div className="flex justify-between">
                  <span className="text-gray-700">試験まで:</span>
                  <span className="font-medium">{stats.daysUntilExam}日</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-700">残り学習時間:</span>
                  <span className="font-medium">{remainingHours.toFixed(1)}時間</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-700">必要な週間学習時間:</span>
                  <span className="font-medium">
                    {((remainingHours / stats.daysUntilExam) * 7).toFixed(1)}h/週
                  </span>
                </div>
                {stats.onTrack ? (
                  <div className="mt-3 text-green-800 font-medium">
                    順調です！このペースを維持しましょう
                  </div>
                ) : (
                  <div className="mt-3 text-orange-800 font-medium">
                    学習時間を増やす必要があります
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      )}

      {stats.estimatedCompletion && !stats.daysUntilExam && (
        <div className="bg-white rounded-lg shadow-md p-6">
          <div className="flex items-center gap-2 mb-2">
            <Target className="w-5 h-5 text-gray-700" />
            <h3 className="font-semibold text-gray-900">予想完了日</h3>
          </div>
          <div className="text-sm text-gray-600">
            現在のペースで学習を続けると、
            <span className="font-medium text-gray-900">
              {new Date(stats.estimatedCompletion).toLocaleDateString('ja-JP')}
            </span>
            に450時間を達成できます。
          </div>
        </div>
      )}

      {history.length > 0 && (
        <div className="bg-white rounded-lg shadow-md p-6">
          <h3 className="font-semibold text-gray-900 mb-4 flex items-center gap-2">
            <TrendingUp className="w-5 h-5" />
            過去14日間の学習時間
          </h3>
          <div className="flex items-end gap-1 h-32">
            {history.map((day, index) => {
              const maxMinutes = Math.max(...history.map(d => d.minutes));
              const height = maxMinutes > 0 ? (day.minutes / maxMinutes) * 100 : 0;
              return (
                <div
                  key={index}
                  className="flex-1 flex flex-col items-center gap-1"
                >
                  <div
                    className="w-full bg-blue-500 rounded-t hover:bg-blue-600 transition-colors relative group"
                    style={{ height: `${height}%`, minHeight: day.minutes > 0 ? '4px' : '0' }}
                  >
                    <div className="absolute bottom-full mb-2 left-1/2 transform -translate-x-1/2 bg-gray-900 text-white text-xs py-1 px-2 rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap pointer-events-none">
                      {(day.minutes / 60).toFixed(1)}h
                    </div>
                  </div>
                  <div className="text-xs text-gray-500 transform -rotate-45 origin-top-left mt-2">
                    {new Date(day.date).getDate()}
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      )}

      <div className="bg-gray-50 rounded-lg p-4 text-sm text-gray-600">
        <h4 className="font-medium text-gray-900 mb-2">参考: 学習時間の目安</h4>
        <ul className="space-y-1">
          <li>• 週25時間のペース → 18週間（4.5ヶ月）</li>
          <li>• 週20時間のペース → 22.5週間（5.5ヶ月）</li>
          <li>• 週15時間のペース → 30週間（8ヶ月）</li>
          <li>• 週10時間のペース → 45週間（12ヶ月）</li>
        </ul>
        <p className="mt-2 text-xs text-gray-500">
          ※ 週の学習時間が短いほど、忘れたことを思い出す時間がかかり、受験までの期間は伸びます
        </p>
      </div>
    </div>
  );
}
