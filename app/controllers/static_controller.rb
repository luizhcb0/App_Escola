class StaticController < ApplicationController
  include SessionsHelper

  def index
    if !current_user.nil? &&
      (current_user.role.name == 'student' || current_user.role.name == "student_adjacent")
      redirect_to student_report_path(current_user.students[0].id, Date.today)
    end
  end

end
