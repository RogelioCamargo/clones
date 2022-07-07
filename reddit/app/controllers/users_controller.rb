class UsersController < ApplicationController
	def new 
		@user = User.new 
		index :new 
	end

	def create 
		@user = User.new(user_params)
		if @user.save 
			login_user!(@user)
			# redirect_to user_url(@user)
		else
			flash.now[:errors] = @user.errors.full_messages 
			render :new, status: :unprocessable_entity
		end
	end

	private 

	def user_params 
		params.require(:user).permit(:username, :password)
	end
end