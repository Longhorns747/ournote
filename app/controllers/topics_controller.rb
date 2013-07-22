class TopicsController < ApplicationController
	def destroy
		@note = Note.find(params[:note_id])
		@topic = @note.topics.find(params[:id])
		@topic.destroy

		redirect_to edit_user_note_path(@note.user, @note)
	end
end
