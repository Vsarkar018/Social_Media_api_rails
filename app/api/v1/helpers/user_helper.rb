module V1
  module Helpers
    class UserHelper
      class Error < StandardError
        attr_reader :status
        def initialize(message,status)
          super(message)
          @status = status
        end
      end
      def get_user(user_id)
        User.find_by_id(user_id)
      rescue => error
        raise error
      end

      def follow_user(user_id,other_user)
        user1 = User.find_by_id(user_id)
        user1.follow(other_user)
        user1.following
      end
    end
  end
end