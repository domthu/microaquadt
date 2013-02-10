class ImageAsset < ActiveRecord::Base


  belongs_to :batch_image

  belongs_to :micro_array_image


  has_attached_file :photo,
                    :styles => {

                                :small => "100x100#",
                                :minute => "50x50#"

                              },

         :default_style => :small                     

                     #:url => "/:attachment/:basename.:extension",
                     #:path => ":rails_root/public/:attachment/:basename.:extension"

##paperclip version 2.7.0 does not work well with imagemagick. it has a dependency of cocaine v=0.3.2. You need to install a fresh cociane gem or install the paperclip version 2.7.4 which has a fix for this dependency.

  #validates_attachment_presence :photo
  #validates_attachment_size :photo, :less_than => 50.megabytes
  #validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/tiff', 'image/gif']


  before_validation :destroy_image?

  def image_delete
    @image_delete ||= "0"
  end

  def image_delete=(value)
    @image_delete = value
  end

  private
  def destroy_image?
   self.photo.clear if @image_delete == "1" && !photo.dirty?
  end







end
