# This module has the purpose of holdng the models strong parameters so that
# different controllers can use it in order for not having multiple places to
# change when some model be modified

module StrongParamsHolder
  def school_params
    params.require(:school).permit(:name, :professor)
  end

  def person_params
    params.require(:person).permit(:name, :email, :phone)
  end

  def login_params
    params.require(:login).permit(:username, :password, :role)
  end

  def student_params
    params.require(:student).permit(:person, :father_name, :mother_name, :address, :birthday)
  end

  def classroom_params
    params.require(:classroom).permit(:name, :shift, {:professor_ids => []}, {:student_ids => []}, {:activity_ids => []})
  end
end
