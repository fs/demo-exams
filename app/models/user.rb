class User < ActiveRecord::Base
  include Clearance::User
  has_many :user_exams
  has_many :exams, :through => :user_exams
  attr_accessible :name

  defaults :admin => false
  
  def taken?(exam)
    user_exams.find_all_by_exam_id(exam.id).any?(&:finished?)
  end
  
  def passed?(exam)
    user_exams.find_all_by_exam_id(exam.id).any?(&:passed?)
  end
end
