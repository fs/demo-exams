class QuestionsController < ApplicationController
  before_filter :authenticate, :require_admin, :find_exam

  def new
    @question = @exam.questions.build(
      :question_type => params[:single] ? 'single' : 'multiple'
    )
  end
  
  def create
    @question = @exam.questions.build(params[:question])
    if @question.save 
      flash[:notice] = "Successfully created question"
      redirect_to edit_exam_url(@exam)
    else
      render 'new'
    end
  end

  def edit
    @question = @exam.questions.find(params[:id])
  end

  def update
    @question = @exam.questions.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:notice] = "Successfully updated question"
      redirect_to edit_exam_url(@exam)
    else
      render 'edit'
    end
  end

  def change_type
    question = @exam.questions.find(params[:id])
    question.change_type!
    flash[:notice] = "Successfully created question type"
    redirect_to edit_exam_question_url(@exam, question)
  end

  def destroy
    @question = @exam.questions.find(params[:id])
    @question.destroy
    flash[:notice] = "Successfully deleted question"
    redirect_to edit_exam_url(@exam)
  end
  
  private
  
  def find_exam
    @exam = Exam.find(params[:exam_id])
  end
end
