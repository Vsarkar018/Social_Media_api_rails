module V1
  class UserApi < Grape::API
    version 'v1' , using: :path
    format :json

    resources :user do
      desc "follow a user"
      # params do
      #   requires :other_user_id, type: Integer, desc: "user id of the user to be followed"
      # end
      post do
        user1 = User.find_by_id(1)
        user2 = User.find_by_id(3)
        user1.follow(user2)
        { following: user1.following , followers: user1.followers }
      end
      post '/unfollow' do
        user1 = User.find_by_id(1)
        user2 = User.find_by_id(3)
        user1.unfollow(user2)
        { following: user1.following , followers: user1.followers }
      end
      get do
        user1 = User.find_by_id(1)
        user1.following
      end
      delete do
        User.destroy_by(id:2)
      end
    end
  end
end