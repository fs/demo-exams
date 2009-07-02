class ExamController < ApplicationController
 before_filter :init_exams

  def index

  end

  def show

  end
  
  private

  def init_exams
    @exams = Exams.all
  end
end
