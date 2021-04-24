require 'rails_helper'

RSpec.describe Auth, type: :model do
  let (:user) { User.create(username: 'username', password: 'password') }
  let (:client) { Client.create(client_name: 'client') }
  let (:userApp) {UserApp.create(user_id: user.id, client_id: client.id)}
  let (:auth) {userApp.create_auth()}

  context 'generation tests' do
    it 'should generate an auth_code' do
      expect(auth.auth_code).not_to eq('')
      expect(auth.auth_code).not_to eq(nil)
    end
  end

  context 'association tests' do
    it 'should belong to a userApp' do
      expect(UserApp.find(auth.user_app_id)).to eq(userApp)
    end
  end
end
