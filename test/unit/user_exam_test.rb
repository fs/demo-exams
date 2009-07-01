require File.dirname(__FILE__) + '/../test_helper'

class UserExamTest < ActiveSupport::TestCase

  context 'Expired user exam' do
    setup do
      @user_exam = Factory(:user_exam_expired)
    end

    should 'should determine when expired' do
      assert @user_exam.expired?
    end
  end

  context 'Finished user exam' do
    setup do
      @user_exam = Factory(:user_exam_finished)
    end

    should 'should determine when finished' do
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

  context 'UserExam model associations' do
    setup do
      @user = Factory(:user)
      @exam = Factory(:exam)
      UserExam.start!(@user, @exam)
      @user_exam_from_user = nil
      @user.user_exams.each do |ue|
        if ue.exam_id == @exam.id
          @user_exam_from_user = ue
          break
        end
      end
      @user_exam_from_exam = nil 
      @exam.user_exams.each do |ue|
        if ue.user_id == @user.id
          @user_exam_from_exam = ue
          break
        end
      end
    end

    should 'User - UserExam - Exam associations is valid' do
      assert_equal @user_exam_from_exam, @user_exam_from_user
    end

    should 'UserQuestions are filled with blank' do
      assert_equal @exam.question_count, @user_exam_from_user.user_questions.length
    end
  end
end