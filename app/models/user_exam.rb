class UserExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam

  has_many :user_questions
  has_many :questions, :through => :user_questions

  validates_presence_of :user_id, :exam_id

  def expired?
    return false if finished?
    return (self.created_at + exam.time_limit.minutes) < Time.now
  end
  
  def finished?
    !self.finished_at.nil?
  end

  def correct_answer!
    increment(:finished_count)
    self.finished_at = Time.now if finished_count == exam.question_count
    save
  end

  class << self
    def start!(user, exam)
      returning nil do |user_exam|
        transaction do
          user_exam = create(:exam_id => exam.id, :user_id => user.id)

          exam.questions.sort_by{ rand }[0...exam.question_count].each do |question|
            user_exam.questions << question
          end
        end
      end
    end
  end
end
