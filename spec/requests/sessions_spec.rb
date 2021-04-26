require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  context "GET /new" do
    before(:each) { get '/login' }

    it 'should respond successfully' do
      expect(response.ok?).to eq(true)
    end

    it 'should generate an html page' do
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end
end
