require 'rails_helper'

RSpec.describe UserApp, type: :model do
  context 'validation tests' do
    let (:user) { User.create(username: 'username', password: 'password') }
    let (:client) { Client.create(client_name: 'client') }
    let (:auth) {Auth.create()}
    let (:token) {Token.create()}

    it 'should have a user id' do
      userApp = UserApp.new(user_id: user.id).save
      expect(userApp).to eql(false)
    end

    it 'should have a client id' do
      userApp = UserApp.new(client_id: client.id).save
      expect(userApp).to eql(false)
    end

    it 'should not save without auth_id or token_id' do
      userApp = UserApp.new(user_id: user.id, client_id: client.id).save
      expect(userApp).to eql(false)
    end

    it 'should save with auth_id' do
      userApp = UserApp.new(user_id: user.id, client_id: client.id, auth_id: auth.id).save
      expect(userApp).to eql(true)
    end

    it 'should save with token_id' do
      userApp = UserApp.new(user_id: user.id, client_id: client.id, token_id: token.id).save
      expect(userApp).to eql(true)
    end

    it 'should not save with both auth_id and token_id' do
      userApp = UserApp.new(user_id: user.id, client_id: client.id, auth_id: auth.id, token_id: token.id).save
      expect(userApp).to eql(false)
    end
  end

  context 'association tests' do
    let (:user) { User.create(username: 'username', password: 'password') }
    let (:client) { Client.create(client_name: 'client') }
    let (:token) {Token.create()}
    let (:userApp) {UserApp.create(user_id: user.id, client_id: client.id, token_id: token.id)}

    it 'should have many users' do
      expect(userApp.users).not_to eq(nil)
    end

    it 'should find the user' do
      expect(userApp.users.find(user.id)).to eq(user)
    end

    it 'should have many clients' do
      expect(userApp.clients).not_to eq(nil)
    end

    it 'should find the client' do
      expect(userApp.clients.find(client.id)).to eq(client)
    end
  end
end
