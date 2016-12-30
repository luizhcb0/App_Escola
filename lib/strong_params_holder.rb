# This module has the purpose of holdng the models strong parameters so that
# different controllers can use it in order for not having multiple places to
# change when some model be modified

module StrongParamsHolder
  def school_params
    params.require(:school).permit(:name, :professor)
  end

  def user_params
    params.require(:user).permit(:name, :phone, :email, :password, :password_confirmation)
  end

  def student_params
    params.require(:student).permit(:name, :address, :birthday)
  end

  def classroom_params
    params.require(:classroom).permit(:name, :shift, :professor_ids => [],
      :student_ids => [], :activity_ids => [])
  end

  def message_params
    params.require(:message).permit(:text, :professor_id, :student_ids => [])
  end

  def activity_params
    params.require(:activity).permit(:name, :activity_category_id, :classroom_ids => [])
  end
end
