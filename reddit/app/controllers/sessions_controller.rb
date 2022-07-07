class SessionsController < ApplicationController
	before_action :require_user!, only: %i(destroy)

	def new 
		render :new 
	end

	def create 
		user = User.find_by_credentials(
			params[:user][:username],
			params[:user][:password]
		)
		if user.nil? 
			flash.now[:errors] = 'Invalid Credentials'
			render :new, status: :unprocessable_entity
		else 
			login_user!(user)
			# redirect_to user_url(user)
		end
	end

	def destroy 
		logout_user! 
		redirect_to new_session_url
	end
end