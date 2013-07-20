class NotesController < ApplicationController
	def new
		@note = Note.new
	end
	
	def edit
  		@note = User.find(params[:user_id]).notes.find(params[:id])
	end

	def create
		@user = User.find(params[:user_id])
		@note = @user.notes.create(params[:note].permit(:topic, :c_name, :content))

		if @note.valid?
			redirect_to user_path(@user)
		else
			redirect_to user_path(@user, :valid => ['invalid'])
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@note = @user.notes.find(params[:id])
		@note.destroy

		redirect_to user_path(@user)
	end

	def update
		@note = User.find(params[:user_id]).notes.find(params[:id])
 
  		if @note.update(params[:note].permit(:topic, :c_name, :content))
    		redirect_to @note.user
  		else
    		render 'edit'
  		end
	end
end
