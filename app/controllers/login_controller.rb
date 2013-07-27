class LoginController < ApplicationController
	def create
		reset_session
		@user = User.find_by(username: params[:login][:username], password: params[:login][:password])

		if(@user.nil?)
			render 'invalid'
		else
			session[:user_id] = @user.id
			redirect_to @user
		end
	end

	def logout
		reset_session
		render 'index'
	end

	def index
		if(session[:user_id].present?)
			redirect_to user_path(User.find(session[:user_id]))
		else
			render 'index'
		end
	end
end
