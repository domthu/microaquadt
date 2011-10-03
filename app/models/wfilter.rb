class Wfilter < ActiveRecord::Base
  validates_presence_of :name

  #has_many :sampling
  belongs_to :sampling_site
end

