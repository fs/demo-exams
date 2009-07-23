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
    if exam = Exam.create(params[:exam])
      flash[:notice] = 'New Exam succesfully created'
    else
      flash[:error] = 'Could not create new Exam' 
    end
    redirect_to(edit_exam_path(exam.id))
  end

  def edit
    @exam = Exam.find(params[:id])
  end

  def update
    if Exam.update(params[:id], params[:exam])
      flash[:notice] = 'Exam successfully updated'
    else
      flash[:erorr] = 'Could not update Exam' 
    end
    redirect_to :back
  end

end
