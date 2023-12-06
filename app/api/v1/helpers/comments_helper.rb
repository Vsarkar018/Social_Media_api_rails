module V1
  module Helpers
    module CommentsHelper
      def create_comment(content,post_id,user_id)
        Comment.create!(content: content, post_id: post_id, user_id: user_id)
      end

      def update_comment(content, comment_id)
        comment = Comment.find_by_id(comment_id)
        comment.content = content
        comment.save!
      end

      def get_comment(comment_id)
        Comment.find_by_id(comment_id)
      end

      def get_all_comments_of_post(post_id)
        Comment.where(post_id: post_id)
      end
      def delete_comment(comment_id)
        Comment.destroy(comment_id)
      end
    end
  end
end