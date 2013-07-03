class User < ActiveRecord::Base
	validates_presence_of :username
	validates_presence_of :email
	validates_presence_of :school
	validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

end
