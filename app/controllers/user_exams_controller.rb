class UserExamsController < ApplicationController
  before_filter :authenticate

  def index
    @user_exams = current_user.user_exams
  end

  def create
    authenticate && return if current_user.nil?
    user_exam = UserExam.start!(current_user, Exam.find(params[:user_exam][:exam_id]))
    redirect_to(edit_user_question_path(user_exam.next_question))
  end
end
