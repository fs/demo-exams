Factory.define :user_exam do |user_exam|
  user_exam.association :user, :factory => :user
  user_exam.association :exam, :factory => :exam
end

Factory.define :user_exam_expired, :parent => :user_exam do |user_exam|
  user_exam.finished_at nil
  user_exam.created_at 30.minutes.ago
end

Factory.define :user_exam_finished, :parent => :user_exam do |user_exam|
  user_exam.finished_count 5
  user_exam.finished_at 10.minutes.ago
end

Factory.define :user_exam_with_last_question, :parent => :user_exam do |user_exam|
  user_exam.finished_count 4
end