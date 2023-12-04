require 'rails_helper'

RSpec.describe "PostApis", type: :request do
  before(:each) do
    @post = create(:post)
  end
    describe 'POST /v1/post' do
      context 'with valid parameters' do
        it 'creates a new post' do
          post_params = {
            caption: @post.caption,
            images: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'files', 'example.jpg'), 'image/jpg')
          }
          post '/api/v1/post', params: post_params
          expect(response).to have_http_status(200)
        end
      end
    context 'with invalid parameters' do
      it 'returns a 400 status and error message for invalid image format' do
        post '/api/v1/post', params: {}
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /v1/post/:id' do
    context 'when the post exists' do
      it 'returns the post details' do
        get "/api/v1/post/#{@post.id}"
        expect(response).to have_http_status(200)
        expect(json_response).to eq(JSON.parse(@post.to_json))
      end
    end

    context 'when the post does not exist' do
      it 'returns a 404 status and error message' do
        get "/api/v1/post/-1"
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'PUT /v1/post/:id' do
    it 'updates the post' do
      put "/api/v1/post/#{@post.id}", params: {caption:"updated caption"}
      expect(response).to have_http_status(200)
      expect(json_response["caption"]).to eq("updated caption")
    end
    it 'returns error with invalid parameters' do
      put "/api/v1/post/#{@post.id}", params: {}
      expect(response).to have_http_status(400)
    end
  end

  describe 'DELETE /v1/post/:id' do
    pending 'deletes the post' do
      delete "/api/v1/post/#{@post.id}"
      # byebug
      expect(response).to have_http_status(200)
      # byebug
      expect(json_response).to eq(1)
    end
    it "return 0 if post doesn't exits" do
      delete "/api/v1/post/#{@post.id}"
      expect(response).to have_http_status(200)
      expect(json_response).to eq(0)
    end

  end
end
