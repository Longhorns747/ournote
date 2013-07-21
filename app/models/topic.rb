class Topic < ActiveRecord::Base
  belongs_to :note

  validates_presence_of :topic
end
