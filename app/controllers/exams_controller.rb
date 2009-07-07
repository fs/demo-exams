class ExamsController < ApplicationController
  before_filter :authenticate

  def index
    @exams = Exam.all
  end

  def show
    @exam = Exam.find(params[:id])
    @user_exam = @exam.user_exams.build
  end
end
