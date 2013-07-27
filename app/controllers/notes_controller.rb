class NotesController < ApplicationController
	def new
		@note = Note.new
	end
	
	def edit
  		@note = User.find(params[:user_id]).notes.find(params[:id])
	end

	def create
		#Get the user and then build the note
		@user = User.find(params[:user_id])
		@note = @user.notes.build(params[:note].permit(:c_name))

		#Split the topics by comma delimiter, then build
		topics = params[:note].permit(:topics)['topics'].split(',')
		topics.each do |topic|
			@note.topics.build(:topic => topic.strip)
		end

		if @note.valid?
			#If the note is valid, now we need to check the file
			if NoteContent.new(params[:note].permit(:content)).valid?
				#If the file is valid, save the note and associate the file with it
				@note.save
				@note.note_contents.create(params[:note].permit(:content))
				redirect_to user_path(@user)
			else
				#Otherwise redirect invalid
				redirect_to user_path(@user, :invalid => ['set'])
			end

		else
			redirect_to user_path(@user, :invalid => ['set'])
		end
	end

	def destroy
		#Find the note and user and destroy them. Associations should be destroyed by cascade.
		@user = User.find(params[:user_id])
		@note = @user.notes.find(params[:id])
		@note.destroy

		redirect_to user_path(@user)
	end

	def update
		@note = User.find(params[:user_id]).notes.find(params[:id])

		#If theere is a class, update the note
  		if @note.update(params[:note].permit(:c_name))

  			#Add topics
			topics = params[:note].permit(:topics)['topics'].split(',')

			topics.each do |topic|
				@note.topics.create(:topic => topic.strip)
			end

			#Add files
			note_content = @note.note_contents.build(params[:note].permit(:content))

			#Make sure we only save the file if it exists and is valid
			unless note_content.nil?
				#If file is valid, save it, otherwise redirect with an error
	  			if note_content.valid?
	  				note_content.save
					redirect_to @note.user
				else
					redirect_to edit_user_note_path(@note.user, @note, :invalid => ['set'])
				end
			else
				redirect_to @note.user
			end
  		end
	end

	def search
		@results = Note.search(params[:term])
		render 'notes/search'
	end
end
