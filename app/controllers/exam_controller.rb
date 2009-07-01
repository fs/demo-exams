class ExamController < ApplicationController

  def index

  end
  def show

  end
  
  private
  def init_exams
    @exams = Exams.all
  end
end
