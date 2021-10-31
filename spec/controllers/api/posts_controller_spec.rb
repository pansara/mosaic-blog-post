require 'rails_helper'

RSpec.describe Api::PostsController, type: :controller do
  
  describe '#index' do
    it "returns an error if no tags passed" do 
      get api_posts

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(JSON.parse(response.status)).to eq (400)
    end
  end
end
