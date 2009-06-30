class Question < ActiveRecord::Base
  belongs_to :exam
  validates_presence_of :question, :question_type
  validates_length_of :question_type, :within => 3..250
  validates_inclusion_of :question_type, :in => %w{multi single}
  serialize :answers_list
end
