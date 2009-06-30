class UserExam < ActiveRecord::Base
  belongs_to :user, :exam
  has_many :user_answer
  validates_presence_of :user_id, :exam_id

  def expired?
    self.finished? ? false : (self.created_at + self.exam.time_limit.minutes) > Time.now
  end
  
  def finished?
    !self.finished_at.nil?
  end
end
