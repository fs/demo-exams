class UserQuestion < ActiveRecord::Base
  belongs_to :user_exam
  belongs_to :question
  validates_presence_of :user_exam_id, :question_id

  # Returns true if answer is accepted or false if question already answered or
  # if exam expired or finished
  #
  def answer!(answers)
    return false if user_exam.expired? || user_exam.finished? || !allow_answer?

    correct = (answers || []).map(&:to_i).sort == question.answers_list
    update_attribute(:correct, correct)
    user_exam.answer!

    correct
  end

  def allow_answer?
    correct.nil?
  end
end
