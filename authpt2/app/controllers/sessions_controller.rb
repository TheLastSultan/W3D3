class SessionsController < ApplicationController


  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password_digest]
    )

    @user = user.reset_session_token!

    redirect_to "/cats"
  end

  def destroy
    @user = current_user
    @user.reset_session_token!
    @user.session_token = nil
  end

end
