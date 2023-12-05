module V1
  class UserApi < Grape::API
    version 'v1' , using: :path
    format :json

    use Middleware::AuthMiddleware

    helpers Helpers::UserHelper


    before do
      @current_user = env['current_user']
    end

    resources :user do
      desc "get user data"
      get do
        get_user(@current_user[:user_id])
      end

      desc "follow and unfollow a user"
      post ':other_user_id' do
        this_user =  get_user(@current_user[:user_id])
        other_user = get_user(params[:other_user_id])
        if this_user.following.include?(other_user)
          this_user.unfollow(other_user)
          status 200
          present message: "User unfollowed"
        else
          this_user.follow(other_user)
          status 200
          {message: "user followed"}
        end
      end

      desc "get following of the user"
      get '/following' do
        this_user = get_user(@current_user[:user_id])
        this_user.following
      end
      desc "get followers of the user"
      get '/followers' do
        this_user = get_user(@current_user[:user_id])
        this_user.followers
      end
    end
  end
end