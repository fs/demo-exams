class UserExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam
  has_many :user_answers
  validates_presence_of :user_id, :exam_id

  def self.start! (user, exam)
    user_exam = self.create( :user_id => user.id, :exam_id => exam.id)
    exam.questions.sort_by{ rand }[0...exam.question_count].each do |v|
      user_exam.user_answers << UserAnswer.create(:user_exam => user_exam.id, :question_id => v.id)
    end
    user_exam
  end

  def answer!(question, *args)
    question.correct = (args == question.answers_list)
  end

  def expired?
    finished? ? false : (created_at + exam.time_limit.minutes) > Time.now
  end
  
  def finished?
    ! finished_at.nil?
  end
end
