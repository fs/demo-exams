class UserQuestion < ActiveRecord::Base
  belongs_to :user_exam
  belongs_to :question
  validates_presence_of :user_exam_id, :question_id

  # Returns true or false if answer is accepted or nil otherwise
  #
  def answer!(answers)
    return false if user_exam.expired? || user_exam.finished? || !correct.nil?

    correct = answers.sort == question.answers_list
    update_attribute(:correct, correct)
    user_exam.answer!

    correct
  end
  
end
