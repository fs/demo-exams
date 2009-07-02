Factory.define :user_question do |user_question|
  user_question.association :user_exam, :factory => :user_exam_without_questions
  user_question.correct nil
  user_question.association :question, :factory => :question
end