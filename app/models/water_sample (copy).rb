class WaterSample < ActiveRecord::Base
  validates_presence_of :Code, :sampling_site, :water_type, :water_use, :geo
  belongs_to :sampling_site
  belongs_to :meteorological_data
  belongs_to :water_type
  belongs_to :water_use
  belongs_to :land_use_mapping
  belongs_to :partner
  belongs_to :geo
end


