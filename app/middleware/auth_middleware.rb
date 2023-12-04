  module V1
    module Middleware
      class AuthMiddleware < Grape::Middleware::Base
        class Error < StandardError
          attr_reader :status
          def initialize(message,status)
            super(message)
            @status = status
          end
        end
        def before
          auth_header = env['HTTP_AUTHORIZATION']
          unless auth_header && auth_header.starts_with?("Bearer ")
            raise Error.new("Authorization Failed",401)
          end
          token = auth_header.split(" ")[1]
          if token.nil? || token.empty? || token == "null" || token.eql?(nil)
            raise  Error.new("Authorization failed",401)
          end
          current_user = JwtService.decode(token)
          env['current_user'] = current_user
        end
      end
    end
  end