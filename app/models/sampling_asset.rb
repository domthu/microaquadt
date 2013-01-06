class SamplingAsset < ActiveRecord::Base

  belongs_to :batch_sampling

  has_attached_file :safi,
                     :url => "/:attachment/:basename.:extension",
                     :path => ":rails_root/public/:attachment/:basename.:extension"

end
