class AddContentToNotes < ActiveRecord::Migration
  def self.up
    add_attachment :notes, :content
  end

  def self.down
    remove_attachment :notes, :content
  end
end
