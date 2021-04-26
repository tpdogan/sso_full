require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  context "GET /new" do
    before(:each) { get '/login' }

    it 'should respond successfully' do
      expect(response.ok?).to eq(true)
    end

    it 'should generate an html page' do
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  context "POST /create" do
    it 'should create a session' do
      user = User.create(username: 'username', password: '123654')
      post '/login', params: { user: {username: 'username', password: '123654'} }
      expect(session.empty?).to eq(false)
    end
  end

  context "DELETE /destroy" do
    it 'should destroy the session' do
      user = User.create(username: 'username', password: '123654')
      post '/login', params: { user: {username: 'username', password: '123654'} }
      expect(session[:user_id]).to eq(user.id)
      delete '/logout'
      expect(session[:user_id]).to eq(nil)
    end
  end
end
