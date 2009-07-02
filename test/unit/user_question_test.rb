require File.dirname(__FILE__) + '/../test_helper'

class UserQuestionTest < ActiveSupport::TestCase
  should_belong_to :user_exam
  should_belong_to :question
  should_validate_presence_of :user_exam_id, :question_id

  context 'UserQuestion answer!' do
    setup do
      @user_question = Factory(:user_question)
    end

    should 'answered right' do
      @user_question.answer!([1])
      assert_equal @user_question.correct, true
      assert_equal @user_question.user_exam.finished_count, 1
    end

    should 'answered wrong' do
      @user_question.answer!([4])
      assert_equal @user_question.correct, false
      assert_equal @user_question.user_exam.finished_count, 1
    end

    should 'deny duplicate answer' do
      @user_question.answer!([1])
      assert_equal @user_question.correct, true
      assert_equal @user_question.user_exam.finished_count, 1
      @user_question.answer!([4])
      assert_equal @user_question.correct, true
      assert_equal @user_question.user_exam.finished_count, 1
    end

    should 'answer returns nil if UserQuestion does not accept second answer on same question' do
      @user_question.answer!([1])
      assert_equal @user_question.correct, true
      assert_equal @user_question.user_exam.finished_count, 1
      assert @user_question.answer!([4]).nil?
    end
  end
end

