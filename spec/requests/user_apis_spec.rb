require 'rails_helper'

RSpec.describe "UserApis", type: :request do
  before(:each) do
    @this_user = create(:user)
    @other_user = create(:user)
    @headers = {'Authorization' => "Bearer #{JwtService.generate_token({user_id:@this_user.id})}"}
  end
  describe 'POST /v1/user/:other_user_id' do
    context 'when the user is not already following' do
      it 'follows the user' do
        allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
        allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @this_user.id })
        post "/api/v1/user/#{@other_user.id}"
        expect(response).to have_http_status(200)
        # byebug
        # expect(json_response['message']).to eq('user followed')
      end
    end
    before(:each) do
      @this_user.follow(@other_user)
    end
    context 'when the user is already following' do

      it 'unfollows the user' do
        allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
        allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @this_user.id })
        post "/api/v1/user/#{@other_user.id}"
        expect(response).to have_http_status(200)
        # expect(json_response['message']).to eq('user unfollowed')
      end
    end
  end

  describe 'GET /v1/user' do
    before(:each) do
      @this_user.follow(@other_user)
    end
    it 'gets the following of the user' do
      allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
      allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @this_user.id })
      get '/api/v1/user/following'
      expect(response).to have_http_status(200)
      expect(json_response).to be_an(Array)
    end
  end

  describe 'GET /v1/user/followers' do
    it 'gets the followers of the user' do
      allow_any_instance_of(V1::Middleware::AuthMiddleware).to receive(:extract_token).and_return('valid_token')
      allow(JwtService).to receive(:decode).with('valid_token').and_return({ user_id: @this_user.id })
      get '/api/v1/user/followers'
      expect(response).to have_http_status(200)
      expect(json_response).to be_an(Array)
    end
  end
end

