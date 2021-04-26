class OauthController < ApplicationController
  def authorize
    client_id = authorize_params[:client_id]
    @client = Client.find_by(client_id: client_id)

    paramsCheck = (["client_id", "redirect_uri", "response_type"] - authorize_params.keys)
    
    # Check if any required key is missing
    if !paramsCheck.empty?
      payload = {
        error: (["client_id", "redirect_uri", "response_type"] - authorize_params.keys).join(",") + " must be supplied.",
        status: 400
      }
      render json: payload, status: :bad_request
    # Check if client does not exist in the system
    elsif !@client
      payload = {
        error: "client_id is unknown.",
        status: 403
      }
      render json: payload, status: :forbidden
    # If valid request is made but user is not logged in
    elsif !session || !session[:user_id]
      redirect_to '/login', params: {redirect_uri: request.original_url}
    end
  end

  def grant_authorization
    client_id = authorize_params[:client_id]
    client = Client.find_by(client_id: client_id)

    if params[:commit] == 'Yes'
      userApp = UserApp.create(:user_id => session[:user_id], :client_id => client.id)
      if userApp.save
        userApp.create_auth
        redirect_to (params[:redirect_uri] + "?code=#{userApp.auth.auth_code}")
      else
        redirect_to params[:redirect_uri]
      end
    else
      redirect_to params[:redirect_uri]
    end
  end

  private

  def authorize_params
    params.permit(:client_id, :redirect_uri, :response_type)
  end
end
