require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'should have a username' do
      userSaved = User.new(password: 'password').save
      expect(userSaved).to eq(false)
    end

    it 'should have a non-empty username' do
      userSaved = User.new(username: '', password: 'password').save
      expect(userSaved).to eq(false)
    end

    it 'should have a password' do
      userSaved = User.new(username: 'username').save
      expect(userSaved).to eq(false)
    end

    it 'should have a non-empty password' do
      userSaved = User.new(username: 'username', password: '').save
      expect(userSaved).to eq(false)
    end

    it 'should save successfully with credentials' do
      userSaved = User.new(username: 'username', password: 'password').save
      expect(userSaved).to eq(true)
    end
  end

  context 'uniqueness test' do
    it 'should have a unique username' do
      user1 = User.new(username: 'username', password: 'password').save
      user2 = User.new(username: 'username', password: 'password').save
      expect(user1).to eq(true)
      expect(user2).to eq(false)
    end
  end

  context 'password tests' do
    it 'should have a minimum password length of 6' do
      user1 = User.new(username: 'username', password: '123').save
      user2 = User.new(username: 'username', password: '123456').save
      expect(user1).to eq(false)
      expect(user2).to eq(true)
    end

    it 'should save password with encryption' do
      pass = '123456'
      user = User.create(username: 'username', password: pass)
      expect(user.password).not_to eq(pass)
    end
  end

  context 'association tests' do
    let (:user) {User.create(username: 'username', password: 'password')}

    it 'should have many userApps' do
      expect(user.user_apps).not_to eq(nil)
    end

    it 'should have many clients' do
      expect(user.clients).not_to eq(nil)
    end
  end
end
