class SessionsController < ApplicationController
  include SessionsHelper

  # if exists, signs in the given user/login
  def create
    @login = Login.find_by(username: params[:username])
    if @login and @login.authenticate(params[:password])
      log_in(@login)
      redirect_to schools_path
    else
      render :new   # re-renders the sign in page
    end
  end

  # signs the current user out
  def destroy
    log_out
    redirect_to new_session_path
  end

end
