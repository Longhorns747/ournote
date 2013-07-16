class NotesController < ApplicationController
	def new
		@note = Note.new
	end
	
	def create
		@user = User.find(params[:user_id])
		@note = @user.notes.create(params[:note].permit(:topic, :c_name, :content))
		redirect_to user_path(@user)
	end

	def destroy
		@user = User.find(params[:user_id])
		@note = @user.notes.find(params[:id])
		@note.destroy

		redirect_to user_path(@user)
	end
end
