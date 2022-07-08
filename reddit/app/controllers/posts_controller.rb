class PostsController < ApplicationController
	before_action :require_logged_in! 
	before_action :require_user_owns_post!, only: %i(edit update)

	def new 
		@post = Post.new 
		render :new 
	end

	def create 
		@post = current_user.posts.new(post_params)
		if @post.save 
			redirect_to post_url(@post)
		else
			flash.now[:errors] = @post.errors.full_messages
			render :new 
		end
	end

	def edit 
		@post = Post.find(params[:id])
		render :edit 
	end

	def update 
		@post = Post.find(params[:id])
		if @post.update(post_params) 
			redirect_to post_url(@post)
		else
			flash.now[:errors] = @post.errors.full_messages
			render :edit
		end
	end

	def show 
		@post = Post.find(params[:id])
		render :show 
	end

	def destroy 
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to subs_url
	end

	private 

	def post_params
		params.require(:post).permit(:title, :content, :url, sub_ids: [])
	end

	def require_user_owns_post!
		return if current_user.posts.find_by(id: params[:id])
		render json: 'Forbidden', status: :forbidden
	end
end