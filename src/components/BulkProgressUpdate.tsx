import { useState, useEffect } from 'react';
import { Check, X, AlertCircle, ChevronDown, ChevronRight, Circle, CheckCircle } from 'lucide-react';
import { supabase } from '../lib/supabase';
import type { Chapter, Task } from '../lib/types';

interface BulkProgressUpdateProps {
  currentRound: number;
  onClose: () => void;
  onSuccess: () => void;
}

interface TaskWithDetails extends Task {
  taskNumber: string;
}

interface Lecture {
  id: string;
  chapter_id: string;
  lecture_number: number;
  title: string;
  duration_minutes: number;
  order_index: number;
  tasks: TaskWithDetails[];
}

interface ChapterWithLectures extends Chapter {
  lectures: Lecture[];
}

export function BulkProgressUpdate({ currentRound, onClose, onSuccess }: BulkProgressUpdateProps) {
  const [chapters, setChapters] = useState<ChapterWithLectures[]>([]);
  const [selectedTasks, setSelectedTasks] = useState<Map<string, 'correct' | 'incorrect'>>(new Map());
  const [expandedChapters, setExpandedChapters] = useState<Set<string>>(new Set());
  const [expandedLectures, setExpandedLectures] = useState<Set<string>>(new Set());
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadChapters();
  }, [currentRound]);

  async function loadChapters() {
    setLoading(true);
    const { data: chaptersData } = await supabase
      .from('chapters')
      .select('*')
      .order('order_index');

    if (chaptersData) {
      const chaptersWithLectures = await Promise.all(
        chaptersData.map(async (chapter) => {
          const { data: lecturesData } = await supabase
            .from('lectures')
            .select('*')
            .eq('chapter_id', chapter.id)
            .order('order_index');

          const lectures: Lecture[] = [];
          if (lecturesData) {
            for (const lecture of lecturesData) {
              const { data: tasksData } = await supabase
                .from('tasks')
                .select('*')
                .eq('lecture_id', lecture.id)
                .lte('round_unlock', currentRound)
                .order('task_type', { ascending: true })
                .order('created_at', { ascending: true });

              const tasks: TaskWithDetails[] = [];
              if (tasksData) {
                tasksData.forEach((task, index) => {
                  const taskNumber = `${chapter.chapter_number}-${lecture.lecture_number}-${task.task_type === 'mc' ? 'MC' : 'TBS'}${index + 1}`;
                  tasks.push({
                    ...task,
                    taskNumber,
                  });
                });
              }

              lectures.push({
                ...lecture,
                tasks,
              });
            }
          }

          return {
            ...chapter,
            lectures,
          };
        })
      );
      setChapters(chaptersWithLectures);
    }
    setLoading(false);
  }

  function toggleChapter(chapterId: string) {
    const newExpanded = new Set(expandedChapters);
    if (newExpanded.has(chapterId)) {
      newExpanded.delete(chapterId);
    } else {
      newExpanded.add(chapterId);
    }
    setExpandedChapters(newExpanded);
  }

  function toggleLecture(lectureId: string) {
    const newExpanded = new Set(expandedLectures);
    if (newExpanded.has(lectureId)) {
      newExpanded.delete(lectureId);
    } else {
      newExpanded.add(lectureId);
    }
    setExpandedLectures(newExpanded);
  }

  function toggleTask(taskId: string, result: 'correct' | 'incorrect') {
    const newSelection = new Map(selectedTasks);
    if (newSelection.has(taskId)) {
      newSelection.delete(taskId);
    } else {
      newSelection.set(taskId, result);
    }
    setSelectedTasks(newSelection);
  }

  function toggleTaskResult(taskId: string, result: 'correct' | 'incorrect') {
    const newSelection = new Map(selectedTasks);
    newSelection.set(taskId, result);
    setSelectedTasks(newSelection);
  }

  function selectAllTasksInLecture(lectureId: string, result: 'correct' | 'incorrect' = 'correct') {
    const chapter = chapters.find((ch) =>
      ch.lectures.some((lec) => lec.id === lectureId)
    );
    const lecture = chapter?.lectures.find((lec) => lec.id === lectureId);
    if (!lecture) return;

    const newSelection = new Map(selectedTasks);
    const allSelected = lecture.tasks.every((task) => newSelection.has(task.id));

    if (allSelected) {
      lecture.tasks.forEach((task) => newSelection.delete(task.id));
    } else {
      lecture.tasks.forEach((task) => newSelection.set(task.id, result));
    }
    setSelectedTasks(newSelection);
  }

  function selectRange(startChapter: number, endChapter: number, result: 'correct' | 'incorrect' = 'correct') {
    const chaptersInRange = chapters.filter(
      (ch) => ch.chapter_number >= startChapter && ch.chapter_number <= endChapter
    );
    const newSelection = new Map(selectedTasks);
    chaptersInRange.forEach((ch) => {
      ch.lectures.forEach((lec) => {
        lec.tasks.forEach((task) => newSelection.set(task.id, result));
      });
    });
    setSelectedTasks(newSelection);
  }

  async function handleSubmit() {
    if (selectedTasks.size === 0) return;

    setIsSubmitting(true);
    try {
      const today = new Date().toISOString().split('T')[0];
      const nextReviewDate = new Date();
      nextReviewDate.setDate(nextReviewDate.getDate() + 7);
      const nextReview = nextReviewDate.toISOString().split('T')[0];

      for (const [taskId, result] of selectedTasks.entries()) {
        const { data: existingProgress } = await supabase
          .from('task_progress')
          .select('*')
          .eq('task_id', taskId)
          .eq('current_round', currentRound)
          .maybeSingle();

        if (existingProgress) {
          if (existingProgress.status !== 'completed') {
            await supabase
              .from('task_progress')
              .update({
                status: 'completed',
                last_result: result,
                completed_at: today,
                next_review_date: nextReview,
              })
              .eq('id', existingProgress.id);
          }
        } else {
          await supabase
            .from('task_progress')
            .insert({
              task_id: taskId,
              current_round: currentRound,
              status: 'completed',
              last_result: result,
              completed_at: today,
              next_review_date: nextReview,
            });
        }
      }

      onSuccess();
      onClose();
    } catch (error) {
      console.error('Failed to update progress:', error);
    } finally {
      setIsSubmitting(false);
    }
  }

  if (loading) {
    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div className="bg-white rounded-lg p-6">
          <p className="text-gray-600">読み込み中...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg w-full max-w-2xl max-h-[90vh] flex flex-col">
        <div className="p-6 border-b border-gray-200">
          <div className="flex justify-between items-start mb-4">
            <div>
              <h2 className="text-2xl font-bold text-gray-900">一括進捗登録</h2>
              <p className="text-sm text-gray-600 mt-1">
                完了した問題を選択して、正解/不正解を記録してください
              </p>
            </div>
            <button
              onClick={onClose}
              className="text-gray-400 hover:text-gray-600 transition-colors"
            >
              <X className="w-6 h-6" />
            </button>
          </div>

          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 flex gap-3">
            <AlertCircle className="w-5 h-5 text-blue-600 flex-shrink-0 mt-0.5" />
            <div className="text-sm text-blue-800">
              <p className="font-medium mb-1">この機能について</p>
              <p className="mb-2">
                チャプター → セクション → 問題と展開し、完了した問題を個別に選択できます。各問題に正解/不正解を設定できます。
              </p>
              <p className="text-xs">
                Round {currentRound}で完了済みとしてマークされます。セクション単位で一括選択も可能です。
              </p>
            </div>
          </div>
        </div>

        <div className="flex-1 overflow-y-auto p-6">
          <div className="mb-4">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              クイック選択（正解として一括選択）
            </label>
            <div className="flex flex-wrap gap-2">
              <button
                onClick={() => selectRange(1, 5, 'correct')}
                className="px-3 py-1 text-sm bg-green-100 hover:bg-green-200 text-green-800 rounded transition-colors"
              >
                Ch 1-5 全問題
              </button>
              <button
                onClick={() => selectRange(6, 10, 'correct')}
                className="px-3 py-1 text-sm bg-green-100 hover:bg-green-200 text-green-800 rounded transition-colors"
              >
                Ch 6-10 全問題
              </button>
              <button
                onClick={() => selectRange(11, 15, 'correct')}
                className="px-3 py-1 text-sm bg-green-100 hover:bg-green-200 text-green-800 rounded transition-colors"
              >
                Ch 11-15 全問題
              </button>
              <button
                onClick={() => selectRange(16, 21, 'correct')}
                className="px-3 py-1 text-sm bg-green-100 hover:bg-green-200 text-green-800 rounded transition-colors"
              >
                Ch 16-21 全問題
              </button>
              <button
                onClick={() => setSelectedTasks(new Map())}
                className="px-3 py-1 text-sm bg-gray-100 hover:bg-gray-200 text-gray-700 rounded transition-colors"
              >
                クリア
              </button>
            </div>
          </div>

          <div className="space-y-2">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              問題選択 ({selectedTasks.size}問選択中)
            </label>
            {chapters.map((chapter) => {
              const isChapterExpanded = expandedChapters.has(chapter.id);
              const chapterTaskCount = chapter.lectures.reduce((sum, lec) => sum + lec.tasks.length, 0);
              const chapterSelectedCount = chapter.lectures.reduce(
                (sum, lec) => sum + lec.tasks.filter((task) => selectedTasks.has(task.id)).length,
                0
              );

              return (
                <div key={chapter.id} className="border border-gray-200 rounded-lg overflow-hidden">
                  <button
                    onClick={() => toggleChapter(chapter.id)}
                    className="w-full flex items-center gap-3 p-3 bg-gray-50 hover:bg-gray-100 transition-colors text-left"
                  >
                    {isChapterExpanded ? (
                      <ChevronDown className="w-5 h-5 text-gray-500" />
                    ) : (
                      <ChevronRight className="w-5 h-5 text-gray-500" />
                    )}
                    <div className="flex-1">
                      <p className="font-medium text-gray-900">
                        Chapter {chapter.chapter_number}: {chapter.title}
                      </p>
                      <p className="text-xs text-gray-500 mt-0.5">
                        {chapterSelectedCount}/{chapterTaskCount} 問選択中 • {chapter.lectures.length} セクション
                      </p>
                    </div>
                  </button>

                  {isChapterExpanded && (
                    <div className="bg-white">
                      {chapter.lectures.map((lecture) => {
                        const isLectureExpanded = expandedLectures.has(lecture.id);
                        const lectureSelectedCount = lecture.tasks.filter((task) =>
                          selectedTasks.has(task.id)
                        ).length;

                        return (
                          <div key={lecture.id} className="border-t border-gray-100">
                            <div className="flex items-center bg-gray-50">
                              <button
                                onClick={() => toggleLecture(lecture.id)}
                                className="flex-1 flex items-center gap-2 p-2 pl-8 hover:bg-gray-100 transition-colors text-left"
                              >
                                {isLectureExpanded ? (
                                  <ChevronDown className="w-4 h-4 text-gray-500" />
                                ) : (
                                  <ChevronRight className="w-4 h-4 text-gray-500" />
                                )}
                                <div className="flex-1 min-w-0">
                                  <p className="font-medium text-gray-900 text-sm">
                                    {chapter.chapter_number}-{lecture.lecture_number} {lecture.title}
                                  </p>
                                  <p className="text-xs text-gray-500">
                                    {lectureSelectedCount}/{lecture.tasks.length}問選択中
                                  </p>
                                </div>
                              </button>
                              {lecture.tasks.length > 0 && (
                                <button
                                  onClick={() => selectAllTasksInLecture(lecture.id, 'correct')}
                                  className="px-3 py-2 text-xs text-blue-600 hover:bg-blue-50 transition-colors"
                                >
                                  {lectureSelectedCount === lecture.tasks.length ? '全解除' : '全選択'}
                                </button>
                              )}
                            </div>

                            {isLectureExpanded && lecture.tasks.length > 0 && (
                              <div className="bg-white">
                                {lecture.tasks.map((task) => {
                                  const isSelected = selectedTasks.has(task.id);
                                  const result = selectedTasks.get(task.id);

                                  return (
                                    <div
                                      key={task.id}
                                      className="flex items-center gap-2 p-2 pl-16 border-t border-gray-50 hover:bg-gray-50"
                                    >
                                      <button
                                        onClick={() => toggleTask(task.id, 'correct')}
                                        className="flex-1 flex items-center gap-2 text-left"
                                      >
                                        <div
                                          className={`w-4 h-4 rounded border flex items-center justify-center flex-shrink-0 ${
                                            isSelected
                                              ? 'bg-blue-500 border-blue-500'
                                              : 'border-gray-300'
                                          }`}
                                        >
                                          {isSelected && <Check className="w-3 h-3 text-white" />}
                                        </div>
                                        <span className="text-sm text-gray-900">
                                          {task.taskNumber}
                                        </span>
                                        <span
                                          className={`text-xs px-2 py-0.5 rounded ${
                                            task.task_type === 'mc'
                                              ? 'bg-blue-100 text-blue-800'
                                              : 'bg-purple-100 text-purple-800'
                                          }`}
                                        >
                                          {task.task_type === 'mc' ? 'MC' : 'TBS'}
                                        </span>
                                      </button>
                                      {isSelected && (
                                        <div className="flex gap-1">
                                          <button
                                            onClick={() => toggleTaskResult(task.id, 'correct')}
                                            className={`px-2 py-1 text-xs rounded transition-colors ${
                                              result === 'correct'
                                                ? 'bg-green-500 text-white'
                                                : 'bg-gray-200 text-gray-600 hover:bg-gray-300'
                                            }`}
                                          >
                                            正解
                                          </button>
                                          <button
                                            onClick={() => toggleTaskResult(task.id, 'incorrect')}
                                            className={`px-2 py-1 text-xs rounded transition-colors ${
                                              result === 'incorrect'
                                                ? 'bg-red-500 text-white'
                                                : 'bg-gray-200 text-gray-600 hover:bg-gray-300'
                                            }`}
                                          >
                                            不正解
                                          </button>
                                        </div>
                                      )}
                                    </div>
                                  );
                                })}
                              </div>
                            )}

                            {isLectureExpanded && lecture.tasks.length === 0 && (
                              <div className="p-3 pl-16 text-sm text-gray-500 bg-white border-t border-gray-50">
                                このセクションには問題がありません
                              </div>
                            )}
                          </div>
                        );
                      })}
                    </div>
                  )}

                  {isChapterExpanded && chapter.lectures.length === 0 && (
                    <div className="p-4 text-sm text-gray-500 text-center bg-white border-t border-gray-100">
                      このチャプターにはセクションがありません
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </div>

        <div className="p-6 border-t border-gray-200 bg-gray-50">
          <div className="flex justify-between items-center">
            <button
              onClick={onClose}
              className="px-4 py-2 text-gray-700 hover:text-gray-900 transition-colors"
              disabled={isSubmitting}
            >
              キャンセル
            </button>
            <button
              onClick={handleSubmit}
              disabled={selectedTasks.size === 0 || isSubmitting}
              className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-300 disabled:cursor-not-allowed transition-colors"
            >
              {isSubmitting ? '登録中...' : `${selectedTasks.size}問を完了にする`}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
