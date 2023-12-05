module V1
  class AuthApi < Grape::API

    version 'v1' , using: :path
    format :json

    helpers Helpers::AuthHelper
    resource :auth do
      desc 'Register User'
      params do
        requires :name, type: String, desc: "Name of the user"
        requires :email, type: String, desc: "Email of the user"
        requires :password, type: String, desc: "Password of the user"
      end

      post :signup do
        user = signup_user(params)
        token = JwtService.generate_token({user_id:user.id,name:user.name,email:user.email})
        {user: user  , token: token }
      end

      desc "Login User"
      params do
        requires :email, type: String, desc: "Email of the user"
        requires :password, type: String, desc: "Password of the user"
      end
      post :login do
        user = login_user(params)
        if user
          token = JwtService.generate_token({user_id: user.id, name: user.name, email: user.email})
          { token: token }
        else
          error!({ error: 'Invalid Credentials' }, 401)
        end
      end
    end
  end
end