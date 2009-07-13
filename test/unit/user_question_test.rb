require File.dirname(__FILE__) + '/../test_helper'

class UserQuestionTest < ActiveSupport::TestCase
  should_belong_to :user_exam
  should_belong_to :question
  should_validate_presence_of :user_exam_id, :question_id

  context 'a user question without answer' do
    setup do
      @user_question = Factory(:user_question)
    end

    should 'save corect answer' do
      assert @user_question.answer!([1])
      assert @user_question.correct
    end

    should 'save wrong answer' do
      assert !@user_question.answer!([4])
      assert !@user_question.correct
    end
  end

  context 'a user question with answer' do
    setup do
      @user_question = Factory(:user_question_with_answer)
    end

    should 'not change correct answer' do
      @user_question.answer!([1])
      assert_equal true, @user_question.correct
    end
  end
  
  context 'a user question from expired exam' do
    setup do
      @user_question = Factory(:user_question_from_expired_exam)
    end


    should 'not change correct answer' do
      @user_question.answer!([1])
      assert_equal nil, @user_question.correct
    end
  end

  context 'a user question from finished exam' do
    setup do
      @user_question = Factory(:user_question_from_finished_exam)
    end


    should 'not change correct answer' do
      @user_question.answer!([1])
      assert_equal nil, @user_question.correct
    end
  end
  
end
