class LandUseMapping < ActiveRecord::Base
  validates_presence_of :name, :message => "Can't be empty, field is mandatory. "
  validates_presence_of :note, :message => "Can't be empty, field is mandatory. "
  validates_length_of :note,
		:maximum => 1000,
		:too_long => "{{count}} characters is the maximum allowed"
  validates_length_of :name,
		:maximum => 50,
		:too_long => "{{count}} characters is the maximum allowed"
  has_many :sampling_sites

  attr_reader :verbose_me
  def verbose_me
    return self.name
  end

end

