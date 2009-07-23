class Question < ActiveRecord::Base
  belongs_to :exam
  validates_presence_of :question, :question_type
  validates_length_of :question_type, :within => 3..250
  validates_inclusion_of :question_type, :in => %w{multi single}
  serialize :answers_list

  def single?
    question_type == 'single'
  end

  # Returns true if given number of answer contains in right ansvers array
  #
  def right?(number)
    return false if answers_list.nil?
    return (answers_list.find_all{ |elem| elem == number}.size != 0)
  end

  # Converts POST array values to right format
  #
  def set_answers(arg)
    self.answers_list = (arg || []).map(&:to_i).sort
  end

  def change_type()
    awailable = get_awailable_types*2
    self.question_type = awailable[awailable.index(question_type) + 1]
    return self
  end

  def get_awailable_types
    return ['multi', 'single']
  end
end
