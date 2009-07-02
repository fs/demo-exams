class UserExamsController < ApplicationController
  before_filter :get_user

  def create
      exam = Exam.find(params[:id])
      redirect_to :action => 'index' if exam.nil?
      user_exam = UserExam.start!(@current_user, exam)
      redirect_to :controller => :user_questions, :action => 'edit', :id => user_exam.user_questions.first.id if user_exam
  end

  def index
    @user_exams = @current_user.user_exams
  end

  private

  def get_user
    @current_user = User.first
  end

end
