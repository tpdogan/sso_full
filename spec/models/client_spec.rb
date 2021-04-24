require 'rails_helper'

RSpec.describe Client, type: :model do
  context 'validation test' do
    it 'should have a name' do
      client = Client.new().save
      expect(client).to eq(false)
    end

    it 'should save successfully with a name' do
      client = Client.new(client_name: 'client').save
      expect(client).to eq(true)
    end
  end

  context 'generation test' do
    let(:client) { Client.create(client_name: 'client') }
    it 'should generate client id' do
      expect(client.client_id).not_to eq('')
      expect(client.client_id).not_to eq(nil)
    end

    it 'should generate client secret' do
      expect(client.client_secret).not_to eq('')
      expect(client.client_secret).not_to eq(nil)
    end
  end
end
