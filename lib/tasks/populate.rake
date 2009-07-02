namespace :db do
  desc "Populate User, Exam and Questions"
  task :populate => :environment do
    raise 'You can run populator only on development env' unless Rails.env.development?

    require 'populator'
    require 'faker'

    # Create uses
    User.populate(1) do |user|
      user.name = Faker::Name.name
    end

    # Create exams
    Exam.populate(5) do |exam|
      exam.name = Faker::Lorem.sentence
      exam.description = Faker::Lorem.paragraph
      exam.question_count = 10
      exam.time_limit = 10

      Question.populate(10) do |question|
        question.exam_id = exam.id
        question.question = Faker::Lorem.paragraph
        question.question_type = ['single', 'multi']
        question.answer_1 = Faker::Lorem.sentence
        question.answer_2 = Faker::Lorem.sentence
        question.answer_3 = Faker::Lorem.sentence
        question.answer_4 = Faker::Lorem.sentence
        question.answer_5 = Faker::Lorem.sentence
        question.answers_list = [[rand(5) + 1]]
      end
    end
  end
end