class NotesController < ApplicationController
	def new
		@note = Note.new
	end
	
	def edit
  		@note = User.find(params[:user_id]).notes.find(params[:id])
	end

	def create
		@user = User.find(params[:user_id])
		@note = @user.notes.build(params[:note].permit(:topic, :c_name))

		if @note.valid?
			if NoteContent.new(params[:note].permit(:content)).valid?
				@note.save
				@note.note_contents.create(params[:note].permit(:content))
				redirect_to user_path(@user)
			else
				redirect_to user_path(@user, :invalid => ['set'])
			end

		else
			redirect_to user_path(@user, :invalid => ['set'])
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
 
  		if @note.update(params[:note].permit(:topic, :c_name)) && 
  			@note.note_contents.create(params[:note].permit(:content))

    		redirect_to @note.user
  		else
    		render 'edit'
  		end
	end
end
