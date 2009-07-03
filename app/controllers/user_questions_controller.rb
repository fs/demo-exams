class UserQuestionsController < ApplicationController
  before_filter :load_user_question, :validate_question

  def edit
  end

  def update
    @user_question.answer!(params[:answers])
    redirect_to_next_question
  end

  private

  def load_user_question
    @user_question = UserQuestion.find(params[:id])
    @next_question = @user_question.user_exam.next_question(@user_question)
  end

  def validate_question
    unless @user_question.user_exam.allow_answer?
      flash[:error] = 'This exam expired or finished'
      redirect_to(user_exams_path) && return
    end

    redirect_to_next_question unless @user_question.allow_answer?
  end

  def redirect_to_next_question
    redirect_to(user_exams_path) && return if @next_question.nil?
    redirect_to(edit_user_question_path(@next_question)) && return
  end
end
