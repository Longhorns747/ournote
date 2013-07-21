class NotecontentsController < ApplicationController
	def destroy
		@note = Note.find(params[:note_id])
		@notecontent = @note.note_contents.find(params[:id])
		@notecontent.destroy

		redirect_to edit_user_note_path(@note.user, @note)
	end
end
