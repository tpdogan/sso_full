require 'rails_helper'

RSpec.describe "Oauths", type: :request do
  context "POST /authorize" do
    it 'should return json content' do
      post '/oauth/authorize'
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it 'should return bad request' do
      post '/oauth/authorize'
      expect(response.bad_request?).to eq(true)
    end

    it 'should return forbidden access' do
      post '/oauth/authorize', params: {client_id: 'random client id', redirect_uri: 'random uri', response_type: 'code'}
      expect(response.bad_request?).to eq(false)
      expect(response.forbidden?).to eq(true)
    end

    it 'should redirect to login page without session' do
      client = Client.create(client_name: 'client')
      post '/oauth/authorize', params: {client_id: client.client_id, redirect_uri: 'random uri', response_type: 'code'}
      expect(response.status).to eq(302)
      expect(response.redirect?).to eq(true)
    end
  end

  context "POST /login" do
    it 'should not login with wrong credentials' do
      post '/oauth/login', params: {username: 'username', password: 'password'}
      expect(response.unauthorized?).to eq(true)
    end

    it 'should login with correct credentials' do
      user = User.create(username: 'username', password: 'password')
      post '/oauth/login', params: {username: 'username', password: 'password'}
      expect(response.ok?).to eq(true)
    end

    it 'should redirect to authorize if parameter includes' do
      user = User.create(username: 'username', password: 'password')
      post '/oauth/login', params: {username: 'username', password: 'password', redirect_uri: '/oauth/authorize'}
      expect(response.status).to eq(302)
      expect(response.redirect?).to eq(true)
    end
  end
end
