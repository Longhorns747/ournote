class AddContentToNoteContent < ActiveRecord::Migration
  def self.up
    add_attachment :note_contents, :content
  end
end
