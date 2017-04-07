module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # log out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # verify the type of user logged in
  def is_user(role_name)
    return current_user.role.name == role_name if logged_in?
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Confirms a logged-in user or redirect
  # def logged_in_user
  #   if !logged_in?
  #     flash[:danger] = "Please log in."
  #     redirect_to session_path
  #   end
  # end

end
