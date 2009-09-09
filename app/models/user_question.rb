class UserQuestion < ActiveRecord::Base
  default_scope :order => :id
  named_scope :incomplete, :conditions => { :correct => nil }
  
  belongs_to :user_exam
  belongs_to :question
  
  validates_presence_of :user_exam_id, :question_id
  validates_presence_of :answers, :on => :update
  validate_on_update :answer_allowed
  
  attr_accessor :answers
  
  def allow_answer?
    user_exam.allow_answer? && correct.nil?
  end
  
  def exam
    user_exam.exam
  end
  
  def next
    questions = user_exam.user_questions.incomplete.all(:conditions => ['id != ?', id])
    if questions.blank?
      nil
    else
      remaining = questions.select {|q| q.id > id }
      remaining.blank? ? questions.first : remaining.first
    end
  end
  
  protected
  
  def before_update
    self.correct = question.correct_answers?(answers)
    user_exam.answer!
  end
  
  def answer_allowed
    unless allow_answer?
      errors.add_to_base('Answer is not allowed')
    end
  end
end
