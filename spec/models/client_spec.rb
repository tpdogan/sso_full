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
end
