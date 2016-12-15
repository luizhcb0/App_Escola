# This module has the purpose of holdng the models strong parameters so that
# different controllers can use it in order for not having multiple places to
# change when some model be modified

module StrongParamsHolder
  def school_params
    params.require(:school).permit(:name, :professor)
  end

  def user_params
    params.require(:user).permit(:name, :phone, :email, :password, :password_confirmation, :role)
  end

  def student_params
    params.require(:student).permit(:name, :address, :birthday)
  end

  def classroom_params
    params.require(:classroom).permit(:name, :shift, :professor_ids => [], :student_ids => [], :activity_ids => [])
  end
end
