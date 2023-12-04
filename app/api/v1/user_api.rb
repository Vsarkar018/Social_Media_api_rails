module V1
  class UserApi < Grape::API
    version 'v1' , using: :path
    format :json

    USER_HELPER = V1::Helpers::UserHelper

    resources :user do
      desc "get user data"
      # get do
      #   USER_HELPER.new.get_user(params[user_id])
      # end

      desc "follow and unfollow a user"
      post ':other_user_id' do
        this_user = USER_HELPER.new.get_user(1)
        other_user = USER_HELPER.new.get_user(params[:other_user_id])
        if this_user.following.include?(other_user)
          this_user.unfollow(other_user)
          status 200
          present message: "User unfollowed"
        end
        this_user.follow(other_user)
        status 200
        {message: "user followed"}
      end

      desc "get folllowing of the user"
      get do
        this_user = USER_HELPER.new.get_user(1)
        this_user.following
      end
      desc "get folllowers of the user"
      get '/followers' do
        this_user = USER_HELPER.new.get_user(2)
        this_user.followers
      end

    end
  end
end