class NotesController < ApplicationController
	def new
		@user = User.find(params[:user_id])
	end
	
	def create
		@user = User.find(params[:user_id])
		@note = @user.notes.create(params[:note].permit(:topic, :c_name, :content))

		redirect_to user_path(@user)
	end
end
