module V1
  class PostApi < Grape::API
    version 'v1', using: :path
    format :json
    POST_HELPER = Helpers::PostHelper

    resource :post do
      desc "Create Post"
      params do
        optional :caption, type: String, desc: "Caption of the Post"
        optional :images, type: Rack::Multipart::UploadedFile, desc: "Image of the post"
      end
      post do
        allowed_types = %w[image/png image/jpg]
          unless params[:images].present? && allowed_types.include?(params['images']['type'])
            status 400
            present error: 'Invalid Image format', images: params[:images]
          end
        POST_HELPER.new.create_post(params,271)
      end

      desc "Get post"
      get ':id' do
        post = POST_HELPER.new.get_post(params[:id])
        if post.blank?
          status 404
          present error: 'Post not found'
        end
        post
      end

      desc "update post"
      # params do
      #   optional :caption, type: String, desc: "Caption of the Post"
      #   optional :images, type: Rack::Multipart::UploadedFile, desc: "Image of the post"
      # end
      put ':id' do
        post = POST_HELPER.new.update_post(params[:id])
        post
      end

      desc "Delete the post"
      delete ':id' do
        POST_HELPER.new.delete_post(params[:id])
      end


      desc "Get all post"
      get do
        POST_HELPER.new.get_all_post_of_user(271)
      end
    end
  end
end

