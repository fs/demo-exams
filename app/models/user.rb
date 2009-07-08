class User < ActiveRecord::Base
  include Clearance::User
  has_many :user_exams
  has_many :exams, :through => :user_exams
  attr_accessible :name

  defaults :admin => false
end
