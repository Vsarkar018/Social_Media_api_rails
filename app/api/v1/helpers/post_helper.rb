module V1
  module Helpers
    class PostHelper
      def create_post(params, user_id)
          data = JSON.parse(params[:data])
          @image_path
          ActiveRecord::Base.transaction do
            post = Post.new(caption: data['caption'], user_id: user_id)
            images = params[:images]
            @image_path = ImageService.save_image(images, user_id)
            post.images << @image_path
            post.save!
            post
          end
        rescue StandardError => e # Ensure block
          FileUtils.rm(@image_path) if File.exist?(@image_path)
          Rails.logger.error("Error creating post: #{e.message}")
          raise e
      end
      def get_post(post_id)
        Post.find_by_id(post_id)
      end
      def update_post(params)
        post = Post.find_by_id(params[:id])
        post.caption = params[:caption]
        post.save!
        post

      end
      def delete_post(post_id)
        post = Post.find_by_id(post_id)
        file_path = post[:images][0]
        FileUtils.rm(file_path) if File.exist?(file_path)
        post.destroy
      end

      def get_all_post_of_user(user_id)
        Post.where(user_id:user_id)
      end
    end
  end
end