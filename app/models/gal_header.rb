class GalHeader < ActiveRecord::Base
 
  include ActionController::UrlWriter
  include ExperimentHelper

  belongs_to :microarraygal

  def edit
        "<a href='" + edit_gal_header_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
       
    end

    def act
        "<a href='" + gal_header_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end

    def gal_id
        self.microarraygal_id.to_s
    end

    def version
        self.gal_version_info.to_s
    end 

    def row_count
        self.gal_row_count.to_s
    end 

    def column_count
        self.gal_column_count.to_s
    end


    def bcount
        self.block_count.to_s
    end
  
    def company
        self.supplier
    end

    def header_upload_date
        self.created_at.to_s
    end


end
