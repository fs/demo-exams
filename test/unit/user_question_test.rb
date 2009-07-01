require File.dirname(__FILE__) + '/../test_helper'

class UserQuestionTest < ActiveSupport::TestCase
  should_belong_to :user_exam
  should_belong_to :question
  should_validate_presence_of :user_exam_id, :question_id
end
