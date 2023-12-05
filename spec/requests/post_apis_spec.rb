require 'rails_helper'

RSpec.describe "PostApis", type: :request do
  before(:each) do
    @post = create(:post)
    @headers = {'Authorization' => "Bearer #{JwtService.generate_token({user_id:@post.user_id})}"}
  end
    describe 'POST /v1/post' do
      context 'with valid parameters' do
        let(:post_params)  do {
          data: { caption: 'Test Caption' }.to_json,
          images: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'files', 'example.jpg'), 'image/jpg')
        }
        end
        it 'creates a new post' do
          allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
          allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @post.user_id })
          post '/api/v1/post', params: post_params
          expect(response).to have_http_status(201)
        end
      end
    context 'with invalid parameters' do
      it 'returns a 400 status and error message for invalid image format' do
        allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
        allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @post.user_id })
        post '/api/v1/post', params: {}
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /v1/post/:id' do
    context 'when the post exists' do
      it 'returns the post details' do
        allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
        allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @post.user_id })
        get "/api/v1/post/#{@post.id}"
        expect(response).to have_http_status(200)
        expect(json_response).to eq(JSON.parse(@post.to_json))
      end
    end

    context 'when the post does not exist' do
      it 'returns a 404 status and error message' do
        allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
        allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @post.user_id })
        get "/api/v1/post/-1"
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'PUT /v1/post/:id' do
    it 'updates the post' do
      allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
      allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @post.user_id })
      put "/api/v1/post/#{@post.id}", params: {caption:"updated caption"}
      expect(response).to have_http_status(200)
      expect(json_response["caption"]).to eq("updated caption")
    end
    it 'returns error with invalid parameters' do
      allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
      allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @post.user_id })
      put "/api/v1/post/#{@post.id}", params: {}
      expect(response).to have_http_status(400)
    end
  end

  describe 'DELETE /v1/post/:id' do
    it 'deletes the post' do
      allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
      allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @post.user_id })
      expect { delete "/api/v1/post/#{@post.id}" }.to change(Post, :count).by(-1)
      expect(response).to have_http_status(200)
    end
    it "return 0 if post doesn't exist" do
      expect(Post.exists?(@post.id)).to eq(true)

      allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
      allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @post.user_id })

      delete "/api/v1/post/#{@post.id}"
      expect(response).to have_http_status(200)
      expect(json_response).to eq(0)
    end

  end
end
