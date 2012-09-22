class Oligo < ActiveRecord::Base

 include ActionController::UrlWriter
 include ExperimentHelper
  
  belongs_to :microarraygal
  belongs_to :gal_header
  belongs_to :gal_block
  belongs_to :oligo_sequence
  belongs_to :experiment



  def edit
        "<a href='" + edit_oligo_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
       
    end

    def act
        "<a href='" + oligo_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end


    def gal_o_code
     Microarraygal.find(microarraygal_id).verbose_me
    end

    def oligo_upload_date
        self.created_at.to_s
    end

    def oligo_id
        self.oligo_sequence_id
    end

    def oligo
        self.code
    end

    def array_info
        "Block:" + self.gal_block_id.to_s + "-" + "Row:" + self.row_number.to_s + "-" + "Column:" + self.column_number.to_s
    end 
   

end
