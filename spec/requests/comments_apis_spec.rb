require 'rails_helper'

RSpec.describe "CommentsApis", type: :request do
  before :each do
    @comment = create(:comment)
    @headers = {'Authorization' => "Bearer #{JwtService.generate_token({user_id:@comment.user_id})}"}

  end
  describe "POST/comments" do
    context "Creates the comment" do
      let(:params) do
        {
          content: @comment.content,
          post_id: @comment.post_id
        }
      end
      it "returns the valid comment" do
        allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
        allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @comment.user_id })
        post '/api/v1/comments' , params: params
        expect(response).to have_http_status(201)
        expect(json_response['content']).to eq(@comment.content)
      end
      it "returns the valid comment" do
        allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
        allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @comment.user_id })
        post '/api/v1/comments' , params: {  }
        expect(response).to have_http_status(400)
      end
    end
  end
  describe "PATCH/comments" do
    context "Updates the comment" do
      let(:params) do
        {
          content: "updated comment",
          comment_id: @comment.id
        }
      end
      it "returns the updated the comment" do
        allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
        allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @comment.user_id })
        patch "/api/v1/comments" ,params: params
        expect(response).to have_http_status(200)
      end
    end
  end
  describe "GET/comments" do
    context "Get Single Comment" do
      it "returns the single comment" do
        allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
        allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @comment.user_id })
        get "/api/v1/comments/#{@comment.id}"
        expect(response).to have_http_status(200)
        expect(json_response[:content]).to eq(@comment.content)
        expect(json_response[:user_id]).to eq(@comment.user_id)
        expect(json_response[:post_id]).to eq(@comment.post_id)
      end
      it "returns error for invalid id" do
        allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
        allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @comment.user_id })
        get "/api/v1/comments/-1"
        expect(response).to have_http_status(200)
      end
    end
  end
end
