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

    if @user
      login!(@user)
    else
      flash.now[:errors] << "Invalid Login credentails"
      render :new
    end
  end

  def destroy
    @user = current_user
    @user.reset_session_token!
    @user.session_token = nil
    redirect_to cat_url
  end

end
