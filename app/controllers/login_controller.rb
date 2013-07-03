class LoginController < ApplicationController
	def create
		@user = User.find_by(username: params[:login][:username], password: params[:login][:password])
		session[:username] = @user.username
		redirect_to @user
	end
end
