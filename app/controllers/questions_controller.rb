class QuestionsController < ApplicationController
  before_filter :authenticate, :admin_action

  def new
    @question = Exam.find(params[:exam_id]).questions.build
    @question.question_type = (params[:single] ? 'single' : 'multi')
  end
  
  def create
    question = Question.create(params[:question])
    question.set_answers(params[:answers])
    if question.save
      flash[:notice] = 'Exam Question successfully created'
    else
      flash[:error] = 'Exam Question does not created'
    end
    redirect_to edit_exam_path(params[:question][:exam_id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    question.attributes = params[:question]
    question.set_answers(params[:answers])
    if question.save
      flash[:notice] = 'Exam Question successfully updated'
    else
      flash[:error] = 'Exam Question does not updated'
    end
    redirect_to edit_exam_path(params[:question][:exam_id])
  end

  def change_type
    question = Question.find(params[:id])
    if question.change_type.save
      flash[:notice] = 'Question type changed successfully'
    else
      flash[:error] = 'Question type could not be changed'
    end
    redirect_to :back
  end

  def destroy
    if Question.delete(params[:id])
      flash[:notice] = 'Exam Question deleted successfully'
    else
      flash[:error] = 'Could not delete Exam Question'
    end
    redirect_to :back
  end

end
