require 'rails_helper'

RSpec.describe Auth, type: :model do
  context 'generation tests' do
    it 'should generate an auth_code' do
      auth = Auth.create()
      expect(auth.auth_code).not_to eq('')
      expect(auth.auth_code).not_to eq(nil)
    end
  end

  context 'association tests' do
    let (:user) { User.create(username: 'username', password: 'password') }
    let (:client) { Client.create(client_name: 'client') }
    let (:auth) {Auth.create()}
    let (:userApp) {UserApp.create(user_id: user.id, client_id: client.id, auth_id: auth.id)}

    it 'should belong to a userApp' do
      expect(auth.user_app).to eq(userApp)
    end
  end
end
