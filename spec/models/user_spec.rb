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
end
