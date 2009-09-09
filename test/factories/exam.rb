Factory.define :exam do |exam|
  exam.name 'Git basics'
  exam.description 'Git basics'
  exam.time_limit 10
  exam.questions_per_attempt 5
end

Factory.define :exam_with_questions, :parent => :exam do |exam|
  exam.questions do |exam|
    returning [] do |questions|
      5.times { questions << exam.association(:question) }
    end
  end
end

Factory.define :exam_with_uncomplete_questions, :parent => :exam do |exam|
  exam.questions do |exam|
    returning [] do |questions|
      4.times { questions << exam.association(:question) }
    end
  end
end