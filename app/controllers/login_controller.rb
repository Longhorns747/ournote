class LoginController < ApplicationController
	def create
		@user = User.find_by(username: params[:login][:username], password: params[:login][:password])

		if(@user.nil?)
			render 'invalid'
		else
			session[:user_id] = @user.id
			redirect_to @user
		end
	end
end
