require 'rails_helper'

RSpec.describe Auth, type: :model do
  context 'generation tests' do
    it 'should generate an auth_code' do
      auth = Auth.new()
      expect(auth.auth_code).not_to eq('')
      expect(auth.auth_code).not_to eq(nil)
    end
  end
end
