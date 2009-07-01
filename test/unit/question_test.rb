require File.dirname(__FILE__) + '/../test_helper'

class QuestionTest < ActiveSupport::TestCase
  should_belong_to :exam
  should_validate_presence_of :question, :question_type
  should_ensure_length_in_range :question_type, (3..250)
end