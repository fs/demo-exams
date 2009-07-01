require File.dirname(__FILE__) + '/../test_helper'

class ExamTest < ActiveSupport::TestCase
  should_have_many :questions
  should_have_many :user_exams
  should_have_many :users, :through => :user_exams

  should_validate_presence_of :name, :question_count, :time_limit
  should_validate_numericality_of :question_count
  should_validate_numericality_of :time_limit
  should_ensure_length_in_range :name, (3..250)
end