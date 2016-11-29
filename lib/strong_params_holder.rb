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
end