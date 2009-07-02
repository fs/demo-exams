require File.dirname(__FILE__) + '/../test_helper'

class UserQuestionTest < ActiveSupport::TestCase
  should_belong_to :user_exam
  should_belong_to :question
  should_validate_presence_of :user_exam_id, :question_id

  context 'a user question instance' do
    setup do
      @user_question = Factory(:user_question)
    end

    should 'save corect answer' do
      assert @user_question.answer!([1])
      assert @user_question.correct
    end

    should 'inc finished count with right answer' do
      @user_question.answer!([1])
      assert_equal 1, @user_question.user_exam.finished_count
    end

    should 'inc finished count with wrong answer' do
      @user_question.answer!([4])
      assert_equal 1, @user_question.user_exam.finished_count
    end

    should 'not save correct answer' do
      @user_question.answer!([4])
      assert_equal false, @user_question.correct
    end

    should 'not change finished count when answering on question with existing answer' do
      user_question = Factory(:user_question_with_answer)
      user_question.answer!([1])

      assert_equal 1, user_question.user_exam.finished_count
    end
  end
end

