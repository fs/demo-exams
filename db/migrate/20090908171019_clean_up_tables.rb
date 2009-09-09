class CleanUpTables < ActiveRecord::Migration
  def self.up
    rename_column :exams, :question_count, :questions_per_attempt
    rename_column :questions, :answers_list, :correct_answers
  end

  def self.down
    rename_column :questions, :correct_answers, :answers_list
    rename_column :exams, :questions_per_attempt, :question_count
  end
end
