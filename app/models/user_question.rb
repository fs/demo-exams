class UserQuestion < ActiveRecord::Base
  belongs_to :user_exam
  belongs_to :question
  validates_presence_of :user_exam_id, :question_id

  # Set correct answer and updates user exams finished attributes
  #
  def answer!(answers)
    return false if (user_exam.expired? || user_exam.finished?) && correct.nil?

    if answers.sort == question.answers_list
      update_attribute(:correct, true)
      user_exam.correct_answer!
    end

    true
  end
end
