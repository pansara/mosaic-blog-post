require 'rails_helper'

RSpec.describe Api::PostsController, type: :controller do
  
  describe 'GET #index' do

    it "returns an error if no tags passed" do 
      get :index

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.body).to eq('{"error":"tags parameter is required"}')
      expect(response.status).to eq(400)
    end

    let (:posts_params_tags_valid) do
      { 
        tags: "tech,jobs"
      }
    end 

    it "returns an http success" do 
      get :index, params: posts_params_tags_valid

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to be_kind_of(Hash)
      expect(JSON.parse(response.body)).to have_key("posts")
    end

    let (:posts_params_sortBy_invalid) do
      { 
        tags: "tech", 
        sortBy: "shivani"
      }
    end

    it "returns an error if invalid sortBy parameter is passed" do 
      get :index, params: posts_params_sortBy_invalid

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.body). to eq('{"error":"sortBy parameter is invalid"}')
      expect(response.status).to eq(400)
    end

    let (:posts_params_sortBy_valid) do
      { 
        tags: "tech", 
        sortBy: "likes"
      }
    end

    it "returns an http success" do 
      get :index, params: posts_params_sortBy_valid

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to be_kind_of(Hash)
      expect(JSON.parse(response.body)).to have_key("posts")
    end

    let (:posts_params_direction_invalid) do
      { 
        tags: "tech", 
        sortBy: "likes",
        direction: "shivani"
      }
    end

    it "returns an error if invalid direction parameter is passed" do 
      get :index, params: posts_params_direction_invalid

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.body). to eq('{"error":"direction parameter is invalid"}')
      expect(response.status).to eq(400)
    end

    let (:posts_params_direction_valid) do
      { 
        tags: "tech", 
        sortBy: "likes",
        direction: "desc"
      }
    end

    it "returns an error if invalid direction parameter is passed" do 
      get :index, params: posts_params_direction_valid

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to be_kind_of(Hash)
      expect(JSON.parse(response.body)).to have_key("posts")
    end

  end
end
