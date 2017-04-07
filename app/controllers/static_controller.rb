class StaticController < ApplicationController
  include SessionsHelper

  def index
    if !current_user.nil?
      if (current_user.role.name == 'student' || current_user.role.name == "student_adjacent")
        redirect_to student_report_path(current_user.students[0].id, Date.today)

      elsif (current_user.role.name == 'professor' )
        redirect_to new_report_path
      end
    end
  end

end
