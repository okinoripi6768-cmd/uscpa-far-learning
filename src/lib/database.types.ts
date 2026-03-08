export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      chapters: {
        Row: {
          id: string
          chapter_number: number
          title: string
          lecture_duration_minutes: number
          order_index: number
          lecture_url: string | null
          created_at: string
        }
        Insert: {
          id?: string
          chapter_number: number
          title: string
          lecture_duration_minutes?: number
          order_index: number
          lecture_url?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          chapter_number?: number
          title?: string
          lecture_duration_minutes?: number
          order_index?: number
          lecture_url?: string | null
          created_at?: string
        }
      }
      lectures: {
        Row: {
          id: string
          chapter_id: string
          lecture_number: number
          title: string
          duration_minutes: number
          video_url: string | null
          order_index: number
          created_at: string
        }
        Insert: {
          id?: string
          chapter_id: string
          lecture_number: number
          title: string
          duration_minutes?: number
          video_url?: string | null
          order_index: number
          created_at?: string
        }
        Update: {
          id?: string
          chapter_id?: string
          lecture_number?: number
          title?: string
          duration_minutes?: number
          video_url?: string | null
          order_index?: number
          created_at?: string
        }
      }
      tasks: {
        Row: {
          id: string
          chapter_id: string
          lecture_id: string | null
          task_type: 'lecture' | 'mc' | 'tbs'
          task_code: string
          title: string
          round_unlock: number
          order_index: number
          created_at: string
        }
        Insert: {
          id?: string
          chapter_id: string
          lecture_id?: string | null
          task_type: 'lecture' | 'mc' | 'tbs'
          task_code: string
          title: string
          round_unlock: number
          order_index: number
          created_at?: string
        }
        Update: {
          id?: string
          chapter_id?: string
          lecture_id?: string | null
          task_type?: 'lecture' | 'mc' | 'tbs'
          task_code?: string
          title?: string
          round_unlock?: number
          order_index?: number
          created_at?: string
        }
      }
      task_progress: {
        Row: {
          id: string
          task_id: string
          current_round: number
          status: 'pending' | 'active' | 'completed'
          last_result: 'correct' | 'incorrect' | null
          last_completed_at: string | null
          next_review_date: string | null
          attempt_count: number
          notes: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          task_id: string
          current_round?: number
          status?: 'pending' | 'active' | 'completed'
          last_result?: 'correct' | 'incorrect' | null
          last_completed_at?: string | null
          next_review_date?: string | null
          attempt_count?: number
          notes?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          task_id?: string
          current_round?: number
          status?: 'pending' | 'active' | 'completed'
          last_result?: 'correct' | 'incorrect' | null
          last_completed_at?: string | null
          next_review_date?: string | null
          attempt_count?: number
          notes?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      user_settings: {
        Row: {
          id: string
          current_round: number
          daily_task_limit: number
          original_daily_task_limit: number
          last_completion_check_date: string | null
          consecutive_completion_days: number
          round_1_start_date: string
          round_2_start_date: string | null
          round_3_start_date: string | null
          round_4_start_date: string | null
          excluded_chapters: Json | null
          target_exam_date: string | null
          weekly_study_hours_target: number
          total_study_minutes: number
          study_start_date: string
          study_plan: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          current_round?: number
          daily_task_limit?: number
          original_daily_task_limit?: number
          last_completion_check_date?: string | null
          consecutive_completion_days?: number
          round_1_start_date?: string
          round_2_start_date?: string | null
          round_3_start_date?: string | null
          round_4_start_date?: string | null
          excluded_chapters?: Json | null
          target_exam_date?: string | null
          weekly_study_hours_target?: number
          total_study_minutes?: number
          study_start_date?: string
          study_plan?: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          current_round?: number
          daily_task_limit?: number
          original_daily_task_limit?: number
          last_completion_check_date?: string | null
          consecutive_completion_days?: number
          round_1_start_date?: string
          round_2_start_date?: string | null
          round_3_start_date?: string | null
          round_4_start_date?: string | null
          excluded_chapters?: Json | null
          target_exam_date?: string | null
          weekly_study_hours_target?: number
          total_study_minutes?: number
          study_start_date?: string
          study_plan?: string
          created_at?: string
          updated_at?: string
        }
      }
      study_sessions: {
        Row: {
          id: string
          date: string
          duration_minutes: number
          chapter_id: string | null
          task_id: string | null
          task_type: 'lecture' | 'mc' | 'tbs' | null
          notes: string | null
          created_at: string
        }
        Insert: {
          id?: string
          date?: string
          duration_minutes: number
          chapter_id?: string | null
          task_id?: string | null
          task_type?: 'lecture' | 'mc' | 'tbs' | null
          notes?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          date?: string
          duration_minutes?: number
          chapter_id?: string | null
          task_id?: string | null
          task_type?: 'lecture' | 'mc' | 'tbs' | null
          notes?: string | null
          created_at?: string
        }
      }
      flashcards: {
        Row: {
          id: string
          chapter_id: string
          term: string
          meaning: string
          far_point: string
          misconception: string
          instant_phrase: string
          order_index: number
          created_at: string
        }
        Insert: {
          id?: string
          chapter_id: string
          term: string
          meaning: string
          far_point: string
          misconception: string
          instant_phrase: string
          order_index?: number
          created_at?: string
        }
        Update: {
          id?: string
          chapter_id?: string
          term?: string
          meaning?: string
          far_point?: string
          misconception?: string
          instant_phrase?: string
          order_index?: number
          created_at?: string
        }
      }
      flashcard_progress: {
        Row: {
          id: string
          user_id: string
          flashcard_id: string
          status: 'not_started' | 'reviewing' | 'mastered'
          last_reviewed_at: string | null
          review_count: number
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          flashcard_id: string
          status?: 'not_started' | 'reviewing' | 'mastered'
          last_reviewed_at?: string | null
          review_count?: number
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          flashcard_id?: string
          status?: 'not_started' | 'reviewing' | 'mastered'
          last_reviewed_at?: string | null
          review_count?: number
          created_at?: string
        }
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
  }
}
