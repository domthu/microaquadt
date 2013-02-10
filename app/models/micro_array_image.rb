class MicroArrayImage < ActiveRecord::Base
	
include ActionController::UrlWriter
include MicroArrayImagesHelper


 validates_presence_of :name, :message => "Can't be empty, field is mandatory. "
 validates_length_of   :name, :maximum => 50

  
  has_many :experiments

  belongs_to :partner

  has_many :image_assets

  accepts_nested_attributes_for :image_assets, :allow_destroy => true





  #In order for form_for to work,

  attr_reader :verbose_me
  def verbose_me

     #change II_Barcode to barcode
            
      img = ImageAsset.find_by_micro_array_image_id(id).photo_file_name 
      basename = img.gsub(/.[(jpg)(png)(tiff)(gif)]/,"")
   
      if barcode.empty?
            return self.icode  + '-' + basename.to_s
        else
            return self.icode  + '-' + basename.to_s  + '-' + self.barcode
        end   
  end

  def edit
        "<a href='" + edit_micro_array_image_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
       
    end

    def act
        "<a href='" + micro_array_image_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end

    def image_date
        return self.created_at.to_s
    end

    def image_code
	     img = ImageAsset.find_by_micro_array_image_id(id).photo_file_name 
	     basename = img.gsub(/.[(jpg)(png)(tiff)(gif)]/,"")
	     pcode = Partner.find(partner_id).code

	     return 'IMG-' + self.id.to_s + '-' +  pcode  + '-' + basename 

    end













end

