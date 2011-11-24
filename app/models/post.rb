class Post < ActiveRecord::Base
	validates_presence_of :name, :title, :message => "Can't be empty, field is mandatory. "

	validates_length_of :title, :minimum => 5
	has_many :comments
end

