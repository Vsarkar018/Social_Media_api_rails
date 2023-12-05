  module V1
    class PostApi < Grape::API
      version 'v1', using: :path
      format :json

      helpers Helpers::PostHelper
      helpers Helpers::UserHelper

      use Middleware::AuthMiddleware

      before do
        @current_user = env['current_user']
      end

      resource :post do
        desc "Create Post"
        params do
          optional :data, type: String, desc: "data of the Post"
          requires :images, type: Rack::Multipart::UploadedFile, desc: "Image of the post"
        end
        post do
          allowed_types = %w[image/png image/jpg image/jpeg]
            unless params[:images].present? && allowed_types.include?(params['images']['type'])
              status 400
              present error: 'Invalid Image format', images: params[:images]
            end
          post = create_post(params,@current_user[:user_id])
          user = get_user(@current_user[:user_id])
          followers = user.followers
          followers.map do |follower|
            PostNotificationJob.perform_async(JSON.parse(follower.to_json),user.name)
          end
          RedisService.set_key("post:#{post.id}",post)
          post
        end

        desc "Get post"
        get ':id' do
          post = RedisService.get_key("post:#{params[:id]}")
          unless post.blank?
            present JSON.parse(post)
          end
          post = get_post(params[:id])
          if post.blank?
            status 404
            present error: "Post Not found"
          else
            RedisService.set_key("post:#{params[:id]}",post)
            post
          end
        end

        desc "update post"
        params do
          requires :caption, type: String, desc: "Caption of the Post"
        end
        put ':id' do
          post = update_post(params)
          RedisService.set_key("post:#{post.id}",post.to_json)
          post
        end

        desc "Delete the post"
        delete ':id' do
          delete_post(params[:id])
          RedisService.del_key("post:#{params[:id]}")
        end


        desc "Get all post"
        get do
          posts = RedisService.get_key("user_post:#{@current_user[:user_id]}")
          unless posts.blank?
            present JSON.parse(posts)
          end
          posts = get_all_post_of_user(1)
          if posts.blank?
            status 404
            present message: "Posts Not found"
          else
            RedisService.set_key("user_post:#{@current_user[:user_id]}",posts)
            posts
          end
        end
      end
    end
  end

