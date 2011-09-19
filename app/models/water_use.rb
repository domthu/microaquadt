#database name water_uses
class WaterUse < ActiveRecord::Base
	validates_presence_of :code, :name
  validates_length_of :code,
		:maximum => 1,
		:too_long => "{{count}} character allowed"
  validates_length_of :name,
		:maximum => 50,
		:too_long => "{{count}} characters is the maximum allowed"
	has_many :sampling_site
end

