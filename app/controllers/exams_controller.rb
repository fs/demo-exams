class ExamsController < ApplicationController
 before_filter :init_exams

  def index

  end

  def show
    @exam_item = Exam.find(params[:id])
  end

  private

  def init_exams
    @exams = Exam.all
  end
end
