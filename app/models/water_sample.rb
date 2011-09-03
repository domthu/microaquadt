class WaterSample < ActiveRecord::Base
  belongs_to :water_sample
  belongs_to :meteorological_data
  belongs_to :water_type
  belongs_to :water_use
  belongs_to :sampling_site
  belongs_to :partner
  belongs_to :geo
end
