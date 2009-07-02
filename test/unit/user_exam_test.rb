require File.dirname(__FILE__) + '/../test_helper'

class UserExamTest < ActiveSupport::TestCase

  context 'Expired user exam' do
    setup do
      @user_exam = Factory(:user_exam_expired)
    end

    should 'determine when expired' do
      assert @user_exam.expired?
    end
  end

  context 'Finished user exam' do
    setup do
      @user_exam = Factory(:user_exam_finished)
    end

    should 'determine when finished' do
      assert @user_exam.finished?
    end
  end

  context 'Just started user exam' do
    setup do
      @user_exam = Factory(:user_exam)
    end

    should 'update finished count' do
      finished_count = @user_exam.finished_count
      @user_exam.correct_answer!
      assert_equal finished_count + 1, @user_exam.finished_count
    end

    should 'not update finished date' do
      finished_at = @user_exam.finished_at
      @user_exam.correct_answer!
      assert_equal finished_at, @user_exam.finished_at
    end
  end

  context 'User exam with last question' do
    setup do
      @user_exam = Factory(:user_exam_with_last_question)
    end

    should 'change update finished date' do
      stub(Time).now { Time.new.change(:hour => 3) }

      @user_exam.correct_answer!
      assert_equal Time.new.change(:hour => 3), @user_exam.finished_at
    end
  end

  should 'start exam' do
    @user = Factory(:user)
    @exam = Factory(:exam)
    user_exam = UserExam.start!(@user, @exam)

    assert_equal @user, user_exam.user
    assert_equal @exam, user_exam.exam
    assert_equal @exam.question_count, user_exam.questions.count
  end
end