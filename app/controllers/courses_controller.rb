class CoursesController < ApplicationController
  def index
    @courses = Course.all.order('name ASC').page(params[:page])
  end

  def show
    @course = Course.find(params[:id])
  end
end
