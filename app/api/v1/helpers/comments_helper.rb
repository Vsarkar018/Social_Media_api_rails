module V1
  module Helpers
    module CommentsHelper
      def create_comment(content,post_id,user_id)
        comment = Comment.create!(content: content, post_id: post_id, user_id: user_id)
        RedisService.set_key("comment:#{comment.id}",comment)
        # RedisService.set_expiry("comment:#{comment.id}",15)
        comment
      end

      def update_comment(content, comment_id)
        comment = Comment.find_by_id(comment_id)
        comment.content = content
        comment.save!
        RedisService.set_key("comment:#{comment.id}",comment)
        comment

      end

      def get_comment(comment_id)
        comment = RedisService.get_key("comment:#{comment_id}")
        if comment.blank?
          comment = Comment.find_by_id(comment_id)
          RedisService.set_key("comment:#{comment_id}",comment)
        end
        comment
      end


      def get_all_comments_of_post(post_id)
        comments = RedisService.get_key("post_comments:#{post_id}")
        if comments.blank?
          comments = Comment.where(post_id:post_id)
          RedisService.set_key("comments_post:#{post_id}",comments)
        end
        comments
      end
      def delete_comment(comment_id)
        Comment.destroy(comment_id)
      end
    end
  end
end