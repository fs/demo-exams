class Question < ActiveRecord::Base
  belongs_to :exam
  validates_presence_of :question, :type
  validates_length_of :type, :within => 3..250
  validates_inclusion_of :type, :in => %w{multi single}
  serialize :answers_list
end
