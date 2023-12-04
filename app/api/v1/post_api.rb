module V1
  class PostApi < Grape::API
    version 'v1', using: :path
    format :json
    POST_HELPER = Helpers::PostHelper # helpers method in controller
    USER_HELPER = Helpers::UserHelper
    REDIS_CLIENT = Redis.new
    resource :post do
      desc "Create Post"
      params do
        optional :data, type: String, desc: "data of the Post"
        requires :images, type: Rack::Multipart::UploadedFile, desc: "Image of the post"
      end
      post do
        allowed_types = %w[image/png image/jpg]
          unless params[:images].present? && allowed_types.include?(params['images']['type'])
            status 400
            present error: 'Invalid Image format', images: params[:images]
          end
        post = POST_HELPER.new.create_post(params,2)
        user = USER_HELPER.new.get_user(2)
        followers = user.followers
        followers.map do |follower|
          PostNotificationJob.perform_async(JSON.parse(follower.to_json),user.name)
        end
        REDIS_CLIENT.set("post:#{post.id}",post.to_json)
        post
      end

      desc "Get post"
      get ':id' do
        post = REDIS_CLIENT.get("post:#{params[:id]}")
        unless post.blank?
          present JSON.parse(post)
        end
        post = POST_HELPER.new.get_post(params[:id])
        if post.blank?
          status 404
          present error: "Post Not found"
        end
        REDIS_CLIENT.set("post:#{params[:id]}",post.to_json)
        post
      end

      desc "update post"
      params do
        requires :caption, type: String, desc: "Caption of the Post"
      end
      put ':id' do
        post = POST_HELPER.new.update_post(params)
        REDIS_CLIENT.set("post:#{post.id}",post.to_json)
        post
      end

      desc "Delete the post"
      delete ':id' do
        POST_HELPER.new.delete_post(params[:id])
        REDIS_CLIENT.del("post:#{params[:id]}")
      end


      desc "Get all post"
      get do
        posts = REDIS_CLIENT.get("user_post:1")
        unless posts.blank?
          present JSON.parse(posts)
        end
        posts = POST_HELPER.new.get_all_post_of_user(1)
        if posts.blank?
          status 404
          present message: "Posts Not found"
        end
        REDIS_CLIENT.set("user_posts:1",posts.to_json)
        posts
      end
    end
  end
end

