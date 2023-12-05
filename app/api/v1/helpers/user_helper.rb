module V1
  module Helpers
    module UserHelper
      def get_user(user_id)
        User.find_by_id(user_id)
      rescue ActiveRecord::RecordInvalid => e
        raise Error.new("Failed to Fetch Details: #{e.message}", 422)
      end
      def follow_user(user_id,other_user)
        user1 = User.find_by_id(user_id)
        user1.follow(other_user)
        user1.following
      end
    end
  end
end