class UserQuestion < ActiveRecord::Base
  belongs_to :user_exam
  belongs_to :question
  validates_presence_of :user_exam_id, :question_id

  # Set correct answer and updates user exams finished attributes
  #
  def answer!(answers)
    if !user_exam.expired? && !user_exam.finished? && correct.nil?
        update_attribute(:correct, answers.sort == question.answers_list)
        user_exam.correct_answer!
    end
  end
end
