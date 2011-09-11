class Geo < ActiveRecord::Base
	validates_presence_of :name, :lon, :lat
	validates_length_of   :name, :maximum => 50
end

