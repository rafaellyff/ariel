module Api
  module V1
    class PostsController < Api::V1::BaseController
      before_action :set_post, only: [:show, :update, :destroy]

      def index
        @posts = Post.all
        render json: @posts
      end
      
      # GET /api/v1/posts/1
      def show
        render json: @post
      end
  
      def create
        @post = Post.new(post_params)#.merge(user: current_user))

        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/posts/1
      def update
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/posts/1
      def destroy
        @post.destroy
      end
      
      private
      
        def set_post
          @post = Post.find(params[:id])
        end
    
        def post_params
          params.require(:post).permit(:title, :text, :author, :source, :tags)
        end
    end
  end
end