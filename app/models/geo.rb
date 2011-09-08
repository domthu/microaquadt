class Geo < ActiveRecord::Base
	validates_presence_of :name, :lon, :lat
end
