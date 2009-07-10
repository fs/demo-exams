class Question < ActiveRecord::Base
  belongs_to :exam
  validates_presence_of :question, :question_type
  validates_length_of :question_type, :within => 3..250
  validates_inclusion_of :question_type, :in => %w{multi single}
  serialize :answers_list

  after_create do |record|
    record.exam.question_count += 1
    record.exam.save
  end
  
  before_destroy do |record|
    record.exam.question.count -= 1
    record.exam.save
  end
  
  def single?
    question_type == 'single'
  end

  def right?(number)
    return false if answers_list.nil?
    return (answers_list.find_all{ |elem| elem == number}.size != 0)
  end

  def set_answers(arg)
    self.answers_list = (arg || []).map(&:to_i).sort
  end
end
