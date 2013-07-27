require 'paperclip'
require 'active_support/core_ext'

class Note < ActiveRecord::Base
  belongs_to :user
  has_many :note_contents, :dependent => :delete_all
  has_many :topics, :dependent => :delete_all

  def self.search(term)
	search_condition = "%" + term + "%"
	full_notes = Note.joins(:note_contents, :topics)

	return full_notes.
		where('topic LIKE ? OR c_name LIKE ? OR content_file_name LIKE ?', search_condition, search_condition, search_condition).
			group("id")
  end
end
