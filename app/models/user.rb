class User < ActiveRecord::Base
  has_many :user_exams
  has_many :exams, :through => :user_exams
end
