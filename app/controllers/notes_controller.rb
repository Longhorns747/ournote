class NotesController < ApplicationController
	def new
		@note = Note.new
	end
	
	def edit
  		@note = User.find(params[:user_id]).notes.find(params[:id])
	end

	def create
		@user = User.find(params[:user_id])
		@note = @user.notes.build(params[:note].permit(:c_name))

		topics = params[:note].permit(:topics)['topics'].split(',')

		topics.each do |topic|
			@note.topics.build(:topic => topic)
		end

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
 
  		if @note.update(params[:note].permit(:topic, :c_name))

  			note_content = @note.note_contents.build(params[:note].permit(:content))

  			if note_content.save
				redirect_to @note.user
			else
				redirect_to edit_user_note_path(@note.user, @note, :invalid => ['set'])
			end

  		else
    		redirect_to edit_user_note_path(@note.user, @note, :invalid => ['set'])
  		end
	end
end
