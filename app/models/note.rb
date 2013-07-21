require 'paperclip'
require 'active_support/core_ext'

class Note < ActiveRecord::Base
  belongs_to :user
  has_many :note_contents, :dependent => :delete_all
  has_many :topics, :dependent => :delete_all
end
