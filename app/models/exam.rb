class Exam < ActiveRecord::Base
  defaults :questions_per_attempt => 0
  
  has_many :questions
  has_many :user_exams
  has_many :users, :through => :user_exams
  
  validates_presence_of :name, :questions_per_attempt, :time_limit
  validates_length_of :name, :within => 3..250
  validates_numericality_of :questions_per_attempt, :time_limit
  
  def questions_count
    [questions.size, questions_per_attempt].min
  end
end
