Factory.define :exam do |exam|
  exam.name 'Git basics'
  exam.description 'Git basics'
  exam.question_count 5
  exam.time_limit 10
end

Factory.define :exam_with_questions, :parent => :exam do |exam|
  exam.questions do |exam|
    returning [] do |questions|
      5.times { questions << exam.association(:question) }
    end
  end
end