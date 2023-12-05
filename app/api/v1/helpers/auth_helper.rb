module V1
  module Helpers
    module AuthHelper
      def signup_user(params)
        User.create!(name: params[:name], email: params[:email], password: params[:password])
      end
      def login_user(params)
        user = User.find_by_email(params[:email])
        return nil unless user && user.authenticate(params[:password])
        user
      end
    end
  end
end