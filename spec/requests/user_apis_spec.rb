require 'rails_helper'

RSpec.describe "UserApis", type: :request do
  before(:each) do
    @this_user = create(:user)
    @other_user = create(:user)
  end
  describe 'POST /v1/user/:other_user_id' do
    context 'when the user is not already following' do
      it 'follows the user' do
        post "/api/v1/user/#{@other_user.id}"
        expect(response).to have_http_status(200)
        expect(json_response['message']).to eq('user followed')
      end
    end
    before(:each) do
      @this_user.follow(@other_user)
    end
    context 'when the user is already following' do

      pending 'unfollows the user' do
        post "/api/v1/user/#{@other_user.id}"
        expect(response).to have_http_status(200)
        expect(json_response['message']).to eq('user unfollowed')
      end
    end
    pending 'returns an error for an invalid user_id' do
      post '/v1/user/-1'
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET /v1/user' do
    before(:each) do
      @this_user.follow(@other_user)
    end
    it 'gets the following of the user' do
      get '/api/v1/user'
      expect(response).to have_http_status(200)
      expect(json_response).to be_an(Array)
    end
  end

  describe 'GET /v1/user/followers' do
    it 'gets the followers of the user' do
      get '/api/v1/user/followers'
      expect(response).to have_http_status(200)
      expect(json_response).to be_an(Array)
    end
  end
end

