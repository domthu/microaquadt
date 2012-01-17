#database name water_types
class WaterType < ActiveRecord::Base
	validates_presence_of  :code, :name, :message => "Can't be empty, field is mandatory. "

    validates_length_of :code,
		:maximum => 1,
		:too_long => "{{count}} character allowed"
    validates_length_of :name,
		:maximum => 50,
		:too_long => "{{count}} characters is the maximum allowed"

	has_many :sampling_sites

  attr_reader :verbose_me
  def verbose_me
    return self.code + ' - ' + self.name
  end

  attr_reader :desc_ellipsis
  def desc_ellipsis
      if !self.description.nil?  
          if self.description.length < 40
            return self.description
          else
            return self.description[0..40] + '...'
          end
      else
        return ""
      end
  end

end

