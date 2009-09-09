class Question < ActiveRecord::Base
  belongs_to :exam
  validates_presence_of :question, :question_type
  validates_length_of :question_type, :within => 3..250
  validates_inclusion_of :question_type, :in => %w{single multiple}
  validate :answers_present
  validate :correct_answers_present
  serialize :correct_answers

  def single?
    question_type == 'single'
  end

  def correct_answer?(number)
    correct_answers.to_a.map(&:to_i).include?(number)
  end
  
  def correct_answers?(answers)
    correct_answers.to_a.map(&:to_i).sort == answers.to_a.map(&:to_i).sort
  end

  def change_type!
    update_attribute :question_type, single? ? 'multiple' : 'single'
  end
  
  private
  
  def answers_present
    if answer_1.blank? && answer_2.blank? && answer_3.blank? && answer_4.blank? && answer_5.blank?
      errors.add_to_base 'Please specify at least one answer'
    end
  end
  
  def correct_answers_present
    if correct_answers.blank?
      errors.add_to_base 'Please specify at least one correct answer'
    end
  end
end
