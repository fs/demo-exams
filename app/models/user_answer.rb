class UserAnswer < ActiveRecord::Base
  belongs_to :user_exam
  belongs_to :question
  validates_presence_of :user_exam_id, :question_id, :correct

  def answer!(*args)
    if !user_exam.expired? && !user_exam.finished?
      correct = (args == question.answers_list)
    end
    if user_exam.user_answers.inject(true) {|result, answer| result && !answer.correct.nil?}
      user_exam.finished_at = Time.now
      user_exam.update
    end
  end
end
