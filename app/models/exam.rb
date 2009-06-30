class Exam < ActiveRecord::Base
  has_many :questions
  has_many :user_exams
  has_many :users, :through => :user_exams
  
  validates_presence_of :name, :question_count, :time_limit
  validates_length_of :name, :within => 3..250
  validates_numericality_of :question_count, :time_limit

  def start(user)
    users << user
  end
end
