class Question < ActiveRecord::Base
  belongs_to :exam
  validates_presence_of :question, :type
  validates_length_of :type, :within => 3..250
<<<<<<< HEAD:app/models/question.rb
  validates_inclusion_of :type, :in => %w{multi single}
  serialize :answers_list
=======
  validates_inclusion_of :type, :in => %w{multi, single}
>>>>>>> ff65d4b216123b66e84799eb6eb6b9543c6af30b:app/models/question.rb
end
