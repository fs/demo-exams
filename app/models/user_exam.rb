class UserExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam

  has_many :user_questions
  has_many :questions, :through => :user_questions

  validates_presence_of :user_id, :exam_id

  defaults :finished_count => 0

  def expired?
    return false if finished?
    return (created_at + exam.time_limit.minutes) < Time.now
  end
  
  def finished?
    !finished_at.nil? && finished_count == exam.question_count
  end

  def correct_answer!
    increment(:finished_count)
    self.finished_at = Time.now if finished_count == exam.question_count
    save
  end

  class << self
    def start!(user, exam)
      user_exam = nil

      transaction do
        user_exam = create(:exam_id => exam.id, :user_id => user.id)
        exam.questions.sort_by{ rand }[0...exam.question_count].each do |question|
          user_exam.questions << question
        end
      end

      user_exam
    end
  end
end
