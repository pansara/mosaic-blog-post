require 'rails_helper'

RSpec.describe Api::PostsController, type: :controller do
  
  describe 'GET #index' do
    before do
      get :index
    end

    it "returns an error if no tags passed" do 
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.body).to eq('{"error":"tags parameter is required"}')
      expect(response.status).to eq(400)
    end

  end
end
