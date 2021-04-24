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
end
