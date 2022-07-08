class SubsController < ApplicationController
	before_action :require_user! 
	before_action :require_user_owns_sub!, only: %i(edit update)

	def new 
		@sub = Sub.new 
		render :new 
	end

	def create 
		@sub = current_user.subs.new(sub_params)
		if @sub.save 
			redirect_to subs_url
		else 
			flash.now[:errors] = @sub.errors.full_messages
			render :new, status: :unprocessable_entity
		end
	end

	def index 
		@subs = Sub.all 
		render :index
	end

	def edit 
		@sub = Sub.find(params[:id])
		render :edit
	end

	def update
		@sub = Sub.find(params[:id])
		if @sub.update(sub_params)
			redirect_to :subs_url
		else
			flash.now[:errors] = @sub.errors.full_messages
			render :edit, status: :unprocessable_entity
		end
	end

	def show 
		@sub = Sub.find(params[:id])
		render :show 
	end

	private 

	def sub_params
		params.require(:sub).permit(:name, :description)
	end

	def require_user_owns_sub!
		return if current_user.subs.find_by(id: params[:id]) 
		render json: 'Forbidden', status: :forbidden 
	end
end