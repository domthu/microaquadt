class SamplingSite < ActiveRecord::Base
  validates_presence_of :Code, :water_type, :water_use, :geo
  belongs_to :water_type
  belongs_to :water_use
  belongs_to :geo
end
