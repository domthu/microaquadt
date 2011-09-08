class LandUseMapping < ActiveRecord::Base
  validates_presence_of :note
  belongs_to :water_sample
end
