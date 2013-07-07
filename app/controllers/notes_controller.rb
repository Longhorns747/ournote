class NotesController < ApplicationController
	def create
		@user = User.find(params[:user_id])
		@note = @user.notes.create(params[:note].permit(:topic, :class, :content))
		redirect_to user_path(@user)
	end
end
