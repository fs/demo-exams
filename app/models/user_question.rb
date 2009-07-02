class UserQuestion < ActiveRecord::Base
  belongs_to :user_exam
  belongs_to :question
  validates_presence_of :user_exam_id, :question_id

  # Returns true or false if answer is accepted or nil otherwise
  #
  def answer!(answers)
    is_right = nil
    if !user_exam.expired? && !user_exam.finished? && correct.nil?
      is_right = answers.sort == question.answers_list
      update_attribute(:correct, is_right)
      user_exam.correct_answer!
    end
    is_right
  end
end
