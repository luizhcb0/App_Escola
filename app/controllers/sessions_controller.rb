class SessionsController < ApplicationController
  include SessionsHelper

  # if exists, signs in the given user/login
  def create
    @user = User.find_by(email: params[:email])
    if @user and @user.authenticate(params[:password])
      log_in(@user)
      redirect_to root_path
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
