class Partner < ActiveRecord::Base
	validates_presence_of :fp7_Number, :Name, :Email
	has_many :person
end
