require 'rails_helper'

RSpec.describe "Oauths", type: :request do
  context "GET /authorize" do
    it 'should return json content' do
      get '/oauth/authorize'
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it 'should return bad request' do
      get '/oauth/authorize'
      expect(response.bad_request?).to eq(true)
    end

    it 'should return forbidden access' do
      get '/oauth/authorize', params: {client_id: 'random client id', redirect_uri: 'random uri', response_type: 'code'}
      expect(response.bad_request?).to eq(false)
      expect(response.forbidden?).to eq(true)
    end

    it 'should redirect to login page without session' do
      client = Client.create(client_name: 'client')
      get '/oauth/authorize', params: {client_id: client.client_id, redirect_uri: 'random uri', response_type: 'code'}
      expect(response.status).to eq(302)
      expect(response.redirect?).to eq(true)
    end

    it 'should view authorize page if user is logged in' do
      user = User.create(username: 'username', password: '123654')
      post '/login', params: { user: {username: 'username', password: '123654'} }

      client = Client.create(client_name: 'client')
      get '/oauth/authorize', params: {client_id: client.client_id, redirect_uri: 'random uri', response_type: 'code'}
  
      expect(response.body).to include("Do you authorize #{client.client_name}?")
    end
  end

  context 'GET /token' do
    user = User.create(username: SecureRandom.alphanumeric(8), password: SecureRandom.alphanumeric(8))
    client = Client.create(client_name: SecureRandom.alphanumeric(8))
    userApp = UserApp.create(user_id: user.id, client_id: client.id)
    userApp.save
    auth = userApp.create_auth
    code = auth.auth_code
    request_params = {
                      client_id: client.client_id,
                      client_secret: client.client_secret,
                      code: code,
                      redirect_uri: 'http://localhost:3000/callback?'
                     }

    it 'should return json content' do
      post '/oauth/token', params: request_params
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it 'should return access token' do
      post '/oauth/token', params: request_params

      body = 
      {
        access_token: userApp.token.access_token,
        token_type: "bearer",
        scope: "read",
        uid: user.id,
        info: {username: user.username}
      }
      expect(response.body).to eq(body.to_json)
    end
  end
end