Factory.define :user_question do |user_question|
  user_question.association :user_exam, :factory => :user_exam_without_questions
  user_question.correct nil
  user_question.association :question, :factory => :question
end

Factory.define :user_question_with_answer, :parent => :user_question do |user_question|
  user_question.user_exam {|user_question| user_question.association(:user_exam_without_questions, :finished_count => 1) }
  user_question.correct true
end

Factory.define :user_question_from_expired_exam, :parent => :user_question do |user_question|
  user_question.association :user_exam, :factory => :user_exam_expired
end

Factory.define :user_question_from_finished_exam, :parent => :user_question do |user_question|
  user_question.association :user_exam, :factory => :user_exam_finished
end


