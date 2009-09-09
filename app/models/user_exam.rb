class UserExam < ActiveRecord::Base
  defaults :finished_count => 0
  
  belongs_to :user
  belongs_to :exam
  has_many :user_questions
  has_many :questions, :through => :user_questions

  validates_presence_of :user_id, :exam_id
  
  before_create :generate_questions

  def expired?
    !finished? && created_at < exam.time_limit.minutes.ago
  end
  
  def time_left
    (exam.time_limit.minutes - (Time.now - created_at)).to_i
  end
  
  def finished?
    !finished_at.nil? && all_questions_answered?
  end
  
  def passed?
    finished? && !user_questions.exists?(:correct => false)
  end
  
  def all_questions_answered?
    finished_count == exam.questions_count
  end

  def allow_answer?
    !expired? && !finished?
  end

  def answer!
    self.finished_count += 1
    self.finished_at = Time.now if all_questions_answered?
    save
  end

  def current_question
    user_questions.incomplete.first
  end
    
  private
  
  def generate_questions
    self.questions = exam.questions.sort_by {rand}[0, exam.questions_count]
  end
end
