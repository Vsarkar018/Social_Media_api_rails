module V1
  module Helpers
    class AuthHelper
      class Error < StandardError
        attr_reader :status

        def initialize(message,status)
          super(message)
          @status = status
        end
      end

      def signup_user(params)
        User.create!(name: params[:name],email: params[:email] , password: params[:password])
      end

      def login_user(params)
        user = User.find_by_email(params[:email])
        if user  && user.authenticate(params[:password])
          user
        elsif !user
          raise Error.new("Account doesn't exist",401)
        else
          raise Error.new("Invalid Credentials",401)
        end
      end
    end
  end
end