class Exam < ActiveRecord::Base
  has_many :questions
  validates_presence_of :name, :question_count, :time_limit 
  validates_length_of :name, :within => 3..250
  validates_numericality_of :question_count, :time_limit

  def start(user)
    user_exam = UserExam.new
    user_exam.user_id = user.id
    user_exam.exam_id = self.id
    user_exam.save!
    user_exam
  end
end
