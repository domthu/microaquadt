class Geo < ActiveRecord::Base
	validates_presence_of :name, :lon, :lat
  validates_length_of :name,
		:maximum => 50,
		:too_long => "{{count}} characters is the maximum allowed"

  #Rails used to have a country_select helper for choosing countries,
  #but this has been extracted to the country_select plugin.

  has_many :sampling_site

  attr_reader :verbose_me
  def verbose_me
    return self.name + ' [' + self.lon.to_s + '/' + self.lat.to_s + ']'
  end

end

