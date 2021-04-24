require 'rails_helper'

RSpec.describe Token, type: :model do
  let (:user) { User.create(username: 'username', password: 'password') }
  let (:client) { Client.create(client_name: 'client') }
  let (:userApp) {UserApp.create(user_id: user.id, client_id: client.id)}
  let (:token) {userApp.create_token}

  context 'generation tests' do
    it 'should generate a token' do
      expect(token.access_token).not_to eq('')
      expect(token.access_token).not_to eq(nil)
    end

    it 'should default type to bearer' do
      expect(token.token_type).to eq('bearer')
    end
  end

  context 'association tests' do
    it 'should belong to a userApp' do
      expect(UserApp.find(token.user_app_id)).to eq(userApp)
    end
  end
end
