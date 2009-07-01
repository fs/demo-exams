Factory.define :exam do |exam|
  exam.name 'Git basics'
  exam.description 'Git basics'
  exam.question_count 5
  exam.time_limit 10
  exam.questions do |exam|
    returning [] do |questions|
      5.times { questions << exam.association(:question) }
    end
  end
end
