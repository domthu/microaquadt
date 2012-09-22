class GalBlock < ActiveRecord::Base

 include ActionController::UrlWriter
 include ExperimentHelper

  
  belongs_to :microarraygal
  belongs_to :gal_header
  
  has_many :oligos

  def edit
        "<a href='" + edit_gal_block_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
       
    end

    def act
        "<a href='" + gal_block_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end

    def gal_id
        self.microarraygal_id.to_s
    end 

    def block
        "Block:" + self.block_number.to_s
    end 

    def x_origin
        self.xOrigin.to_s
    end 

    def y_origin
        self.yOrigin.to_s
    end


    def featureDiameter
        self.feature_diameter.to_s
    end
  
    def x_feature
        self.xFeatures.to_s
    end

    def x_spacing
        self.xSpacing.to_s
    end

    def y_feature
        self.yFeatures.to_s
    end

    def y_spacing
        self.ySpacing.to_s
    end

    def block_upload_date
        self.created_at.to_s
    end

end
