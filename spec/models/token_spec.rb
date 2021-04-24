require 'rails_helper'

RSpec.describe Token, type: :model do
  context 'generation tests' do
    let (:token) {Token.create()}
    it 'should generate a token' do
      expect(token.access_token).not_to eq('')
      expect(token.access_token).not_to eq(nil)
    end

    it 'should default type to bearer' do
      expect(token.token_type).to eq('bearer')
    end
  end

  context 'association tests' do
    let (:user) { User.create(username: 'username', password: 'password') }
    let (:client) { Client.create(client_name: 'client') }
    let (:token) {Token.create()}
    let (:userApp) {UserApp.create(user_id: user.id, client_id: client.id, token_id: token.id)}

    it 'should belong to a userApp' do
      expect(token.user_app).to eq(userApp)
    end
  end
end
