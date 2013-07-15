require 'paperclip'

class Note < ActiveRecord::Base
  belongs_to :user

  has_attached_file :content,
    :storage => 's3',
    :bucket => ENV['AWS_BUCKET'],
    :path => "uploads/:attachment/:id/:styles.:extension",
    :styles => {
      :medium => "300x300>",
      :thumb => "100x100>" },
    :s3_credentials => {
      :access_key_id => ENV['AWS_KEY'],
      :secret_access_key => ENV['AWS_SECRET'] },
    :s3_permissions => 'public-read'
end
