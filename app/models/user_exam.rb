class UserExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam
  has_many :user_answers

  validates_presence_of :user_id, :exam_id

  def expired?
    finished? ? false : (created_at + exam.time_limit.minutes) > Time.now
  end
  
  def finished?
    ! finished_at.nil?
  end

  def correct_answer!
    increment(:finished_count)
    update_attribute(:finished_at, Time.now) if finished_count == exam.question_count
  end

  class << self
    def start! (user, exam)
      base.transaction do
        user_exam = user.exams << exam
      end
      prepare_questions(user_exam) if user_exam
      user_exam
    end

    private :new

    def prepare_questions(user_exam)
      transaction do
        exam = user_exam.exam
        exam.questions.sort_by{ rand }[0...exam.question_count].each do |question|
          user_exam.user_answers.create(:question_id => question.id)
        end
      end
    end
  end
end
