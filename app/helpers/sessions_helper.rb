module SessionsHelper

  # Logs in the given login.
  def log_in(login)
    session[:login_id] = login.id
  end

  # log out the current login
  def log_out
    session.delete(:login_id)
    @current_login = nil
  end

  # Returns the current logged-in user (if any).
  def current_login
    @current_login ||= Login.find_by(id: session[:login_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_login.nil?
  end

  # Confirms a logged-in user or redirect
  # def logged_in_user
  #   if !logged_in?
  #     flash[:danger] = "Please log in."
  #     redirect_to session_path
  #   end
  # end

end
