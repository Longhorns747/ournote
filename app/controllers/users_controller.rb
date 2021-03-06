class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.valid? && @user.save
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
  		@user = User.find(params[:id])

  		if @user.id != session[:user_id]
  			redirect_to login_path
  		end
	end

	private
	  def user_params
	    params.require(:user).permit(:username, :password, :email, :school)
	  end
end
