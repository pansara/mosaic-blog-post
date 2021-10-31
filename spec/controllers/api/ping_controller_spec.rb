require 'rails_helper'

RSpec.describe Api::PingController, type: :controller do
  
  describe 'index (GET /api/ping/index)' do
    before do
      get 'index'
    end
    it "returns success: true if properly connected to the api" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(JSON.parse(response.body)).to include(
        "success"=> true
      )
    end
  end
end
