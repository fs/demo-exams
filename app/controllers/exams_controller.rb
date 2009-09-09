class ExamsController < ApplicationController
  before_filter :authenticate
  before_filter :require_admin, :except => [:index, :show]
  
  def index
    @exams = Exam.all
  end
  
  def show
    @exam = Exam.find(params[:id])
  end
  
  def new
    @exam = Exam.new
  end
  
  def create
    @exam = Exam.new(params[:exam])
    if @exam.save
      flash[:notice] = 'Successfully created an exam'
      redirect_to exams_url
    else
      render 'new'
    end
  end
  
  def edit
    @exam = Exam.find(params[:id])
  end
  
  def update
    @exam = Exam.find(params[:id])
    if @exam.update_attributes(params[:exam])
      flash[:notice] = 'Successfully updated an exam'
      redirect_to exams_url
    else
      render 'edit'
    end
  end
end
