class OauthController < ApplicationController
  def authorize
    client_id = authorize_params[:client_id]
    client = Client.find_by(client_id: client_id)

    paramsCheck = (["client_id", "redirect_uri", "response_type"] - authorize_params.keys)
    
    # Check if any required key is missing
    if !paramsCheck.empty?
      payload = {
        error: (["client_id", "redirect_uri", "response_type"] - authorize_params.keys).join(",") + " must be supplied.",
        status: 400
      }
      render json: payload, status: :bad_request
    # Check if client does not exist in the system
    elsif !client
      payload = {
        error: "client_id is unknown.",
        status: 403
      }
      render json: payload, status: :forbidden
    # If valid request is made but user is not logged in
    else
      redirect_to '/oauth/login', params: {redirect_uri: request.original_url}
    end
  end

  def login
    user = User.find_by(login_params)

    # Check if user does not exist
    if !user
      payload = {
        error: "Username and/or password is not correct.",
        status: 401
      }
      render json: payload, status: :unauthorized
    # Check if it should not redirect after login
    elsif !params[:redirect_uri]
      payload = {
        success: "Welcome #{user.username.capitalize}."
      }
      render json: payload, status: :ok
    # Redirect user after successful login
    else
      session[:user_id] = user.id
      redirect_to params[:redirect_uri]
    end
  end

  private

  def authorize_params
    params.permit(:client_id, :redirect_uri, :response_type)
  end

  def login_params
    require "openssl"
    key = "8a6f4407980a072017cef7204d70604051caff05c4f94f5778d09a0cda844494b775160dd9d1e8cc432df23090abaf1f8df9af93b6ed8105fb05ea990d596a95"
    params[:user][:password] = OpenSSL::HMAC.hexdigest("sha256", key, params[:user][:password])

    params.require(:user).permit(:username, :password)
  end
end
