class Teachers::CoursesController < ApplicationController
  helper_method :classroom
  helper_method :courses

  def index
  end

  def show
  end

  private

  def classroom
    Classroom.new(teacher, course)
  end

  def course
    @course ||= Course.includes(:students).find(params[:id])
  end

  def courses
    @courses ||= teacher.courses.order(:period)
  end

  def teacher
    current_user.teacher
  end
end
