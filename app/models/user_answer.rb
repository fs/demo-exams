class UserAnswer < ActiveRecord::Base
  belongs_to :user_exam, :question
  validates_presence_of :user_exam_id, :question_id, :correct
end
