class QuestionsController < ApplicationController
  before_filter :authenticate, :admin_action

  def new
    @question = Exam.find(params[:exam_id]).questions.build
    @question.question_type = (params[:single] ? 'single' : 'multi')
  end
  
  def create
    question = Question.create(params[:question])
    question.answers_list = params[:answers].map(&:to_i)
    if question.save
      question.exam.question_count += 1
      question.exam.save
    else
      flash[:notice] = 'Exam Question does not created'
    end
    redirect_to exam_path(params[:question][:exam_id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    question.attributes = params[:question]
    question.answers_list = params[:answers].map(&:to_i)
    flash[:notice] = 'Exam Question does not updated' unless question.save
    redirect_to exam_path(params[:question][:exam_id])
  end

  def destroy
    exam = Question.find(params[:id]).exam
    if Question.delete(params[:id])
      exam.question_count -= 1 
      exam.save
    end
    redirect_to :back
  end

end
