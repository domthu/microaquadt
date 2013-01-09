class ImageAsset < ActiveRecord::Base


  belongs_to :batch_image

  has_attached_file :image,
                     :url => "/:attachment/:basename.:extension",
                     :path => ":rails_root/public/:attachment/:basename.:extension"


  #validates_attachment_presence :image
  #validates_attachment_size :image, :less_than => 50.megabytes
  #validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/tiff']




end
