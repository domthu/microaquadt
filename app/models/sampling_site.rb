class SamplingSite < ActiveRecord::Base
  belongs_to :sampling_site
  belongs_to :water_type
  belongs_to :water_use
  belongs_to :geo
end
