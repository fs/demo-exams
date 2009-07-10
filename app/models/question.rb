class Question < ActiveRecord::Base
  belongs_to :exam
  validates_presence_of :question, :question_type
  validates_length_of :question_type, :within => 3..250
  validates_inclusion_of :question_type, :in => %w{multi single}
  serialize :answers_list

  def single?
    question_type == 'single'
  end

  def right?(number)
    return false if answers_list.nil?
    return (answers_list.find_all{ |elem| elem == number}.size != 0)
  end

  private

  def before_save
    answers_list.sort!
  end

  def after_validation_on_create()
    exam.question_count = exam.question_count + 1
    exam.save
  end

  def after_destroy()
    exam.question_count = exam.question_count + 1
    exam.save
  end
end
