class UserExamsController < ApplicationController
  before_filter :authenticate

  def index
    @exams = current_user.user_exams.all(:order => 'updated_at DESC')
  end

  def create
    @exam = current_user.user_exams.create(params[:user_exam])
    redirect_to edit_user_question_path(@exam.current_question)
  end
end
