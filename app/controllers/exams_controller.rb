class ExamsController < ApplicationController
  before_filter :authenticate

  def index
    @exams = Exam.all
  end

  def show
    @exam = Exam.find(params[:id])
    @user_exam = @exam.user_exams.build
  end

  def new
    return unless current_user.admin?
    @exam = Exam.new
  end

  def create
    return unless current_user.admin?
    flash[:notice] = 'Could not create new Exam' unless Exam.create(params[:exam])
    redirect_to(exams_path)
  end

  def edit
    return unless current_user.admin?
    @exam = Exam.find(params[:id])
  end

  def update
    return unless current_user.admin?
    flash[:notice] = 'Could not update Exam' unless Exam.update(params[:id], params[:exam])
    redirect_to exams_path
  end
end
