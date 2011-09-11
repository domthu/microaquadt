class LandUseMapping < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :note
  validates_length_of :note, 
		:maximum => 1000, 
		:too_long => "{{count}} characters is the maximum allowed"
  belongs_to :water_sample
end
