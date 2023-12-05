module  V1

module Middleware
    class AuthMiddleware < Grape::Middleware::Base
      def before
        auth_header = env['HTTP_AUTHORIZATION']
        token = extract_token(auth_header)
        if token.blank?
          error!('Unauthorized', 401)
        end
        begin
          current_user = JwtService.decode(token)
          env['current_user'] = current_user
        rescue JwtService::DecodeError => e
          raise Error.new("Invalid Token: #{e.message}", 401)
        end
      end
      def extract_token(auth_header)
        return nil unless auth_header && auth_header.start_with?("Bearer ")
        token = auth_header.split(" ")[1]
        return nil if token.blank?|| token.nil? || token.empty? || token == "null" || token.eql?(nil)
        token
      end
    end
  end
end