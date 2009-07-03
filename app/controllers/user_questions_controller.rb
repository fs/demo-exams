class UserQuestionsController < ApplicationController
  def edit
    @user_question = UserQuestion.find(params[:id])
  end

  def update
    @user_question = UserQuestion.find(params[:id])
    answers = []
    (1..5).each do |i|
      ans_sym = ('answer_' + i.to_s).to_sym
      answers.push i unless params[ans_sym].nil?
    end
    @user_question.answer!(answers.sort)
    next_question = @user_question.user_exam.next_question(@user_question)
    if next_question.nil?
      redirect_to(user_exams_path)
    else
      redirect_to(edit_user_question_path( next_question))
    end
  end

end
