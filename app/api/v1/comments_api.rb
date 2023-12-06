module V1
  class CommentsApi < Grape::API
    version 'v1' , using: :path
    format :json
    use Middleware::AuthMiddleware
    before do
      @current_user = env['current_user']
    end

    helpers Helpers::CommentsHelper

    resources :comments do
      desc "Create the comments"
      params do
        requires :content, type: String , desc: "Content of the comment"
        requires :post_id , type: Integer , desc: "Id of the post"
      end
      post do
        create_comment(params[:content],params[:post_id],@current_user[:user_id])
      end
      desc "update the comments"
      params do
        requires :content, type: String , desc: "Content of the comment"
        requires :comment_id , type: Integer , desc: "Id of the comment"
      end
      patch do
        update_comment(params[:content],params[:comment_id])
      end

      desc "Get Single Comment"
      get ':id' do
        get_comment(params[:id])
      end

      desc "Get all of the comment of the user"
      params do
        requires :post_id , type: String, desc: "Id of the post"
      end
      get do
        get_all_comments_of_post(params[:post_id])
      end
    end
  end
end