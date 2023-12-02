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
          expect(last_response.status).to eq(201) # Adjust the expected status code
          # Add more expectations based on your response
        end
      end
    context 'with invalid parameters' do
      it 'returns a 400 status and error message for invalid image format' do

      end
    end
  end

  describe 'GET /v1/post/:id' do
    context 'when the post exists' do
      it 'returns the post details' do

      end
    end

    context 'when the post does not exist' do
      it 'returns a 404 status and error message' do

      end
    end
  end

  describe 'PUT /v1/post/:id' do
    it 'updates the post' do

    end
  end

  describe 'DELETE /v1/post/:id' do
    it 'deletes the post' do

    end
  end

  describe 'GET /v1/post' do
    context 'when posts exist for the user' do
      it 'returns the list of posts' do

      end
    end

    context 'when no posts exist for the user' do
      it 'returns a 404 status and error message' do

      end
    end
  end
end
