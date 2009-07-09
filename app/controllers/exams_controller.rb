class ExamsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_action, :except => [:index, :show]

  def index
    @exams = Exam.all
  end

  def show
    @exam = Exam.find(params[:id])
    @user_exam = @exam.user_exams.build
  end

  def new
    @exam = Exam.new
  end

  def create
    flash[:notice] = 'Could not create new Exam' unless Exam.create(params[:exam])
    redirect_to(exams_path)
  end

  def edit
    @exam = Exam.find(params[:id])
  end

  def update
    flash[:notice] = 'Could not update Exam' unless Exam.update(params[:id], params[:exam])
    redirect_to(exams_path)
  end

  private
  
  def admin_action
    redirect_to(exams_path) && return unless current_user.admin?
  end
end
