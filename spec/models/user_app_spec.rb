require 'rails_helper'

RSpec.describe UserApp, type: :model do
  let (:user) { User.create(username: 'username', password: 'password') }
  let (:client) { Client.create(client_name: 'client') }
  let (:userAppCreate) {UserApp.create(user_id: user.id, client_id: client.id)}

  context 'validation tests' do
    it 'should have a client id' do
      userApp = UserApp.new(user_id: user.id).save
      expect(userApp).to eql(false)
    end

    it 'should have a user id' do
      userApp = UserApp.new(client_id: client.id).save
      expect(userApp).to eql(false)
    end

    it 'should save with a user id and a client id' do
      userApp = UserApp.new(user_id: user.id, client_id: client.id).save
      expect(userApp).to eql(true)
    end

    it 'should be able to generate a auth' do
      expect(userAppCreate.create_auth).to eql(userAppCreate.auth)
    end

    it 'should be able to generate a token' do
      expect(userAppCreate.create_token).to eql(userAppCreate.token)
    end

    it 'should not have both auth and token' do
      expect(userAppCreate.create_auth).to eql(userAppCreate.auth)
      expect(userAppCreate.token).to eq(nil)
      expect(userAppCreate.create_token).to eql(userAppCreate.token)
      userAppCreate.reload
      expect(userAppCreate.auth).to eq(nil)
    end
  end

  context 'association tests' do
    it 'should have a user' do
      expect(userAppCreate.user).not_to eq(nil)
      expect(userAppCreate.user).to eq(user)
    end

    it 'should have a client' do
      expect(userAppCreate.client).not_to eq(nil)
      expect(userAppCreate.client).to eq(client)
    end
  end
end
