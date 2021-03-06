module Teachers
  class AssignmentsController < TeachersController
    helper_method :form
    helper_method :available_courses

    def create
      form.submit(assignment_params)
      redirect_to teachers_assignments_path
    end

    def index
      @assignments = Assignment.all
    end

    def new
      @assignment = Assignment.new
    end

    private
    def assignment_params
      params.require(:assignment).permit(:course_id, :name, :description, :assigned_on, :due_on, :points_possible)
    end

    def form
      @form ||= AssignmentForm.new(current_user)
    end

    def available_courses
      teacher.courses
    end

    def teacher
      current_user.teacher
    end
  end
end
