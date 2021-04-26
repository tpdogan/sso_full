class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  def create
    user = User.find_by(login_params)
    session[:user_id] = user.id
  end
  def destroy
    if session
      reset_session
    end
  end

  private

  def login_params
    require "openssl"
    key = "8a6f4407980a072017cef7204d70604051caff05c4f94f5778d09a0cda844494b775160dd9d1e8cc432df23090abaf1f8df9af93b6ed8105fb05ea990d596a95"
    params[:user][:password] = OpenSSL::HMAC.hexdigest("sha256", key, params[:user][:password])

    params.require(:user).permit(:username, :password)
  end
end
