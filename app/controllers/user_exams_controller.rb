class UserExamsController < ApplicationController
  def index
    @user_exams = current_user.user_exams
  end

  def create
    user_exam = UserExam.start!(current_user, Exam.find(params[:user_exam][:exam_id]))
    redirect_to(edit_user_question_path(user_exam.user_questions.first))
  end
end
