class UserQuestionsController < ApplicationController
  before_filter :find_question, :authenticate

  def edit
  end

  def update
    if @question.update_attributes :answers => params[:answers]
      redirect_to_next_question
    else
      flash[:notice] = @question.errors.full_messages.join('<br />')
      redirect_to edit_user_question_path(@question)
    end
  end

  private

  def find_question
    @question = UserQuestion.find(params[:id])
    @next_question = @question.next
    
    if !@question.user_exam.allow_answer?
      flash[:error] = 'This attempt is no longer valid'
      redirect_to user_exams_path
    elsif !@question.allow_answer?
      redirect_to_next_question
    end
  end

  def redirect_to_next_question
    if @next_question.nil?
      redirect_to user_exams_path
    else
      redirect_to edit_user_question_path(@next_question)
    end
  end
end
