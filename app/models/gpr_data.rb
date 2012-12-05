class GprData < ActiveRecord::Base

 include ActionController::UrlWriter
 include ExperimentHelper
  
  belongs_to :microarraygpr
  belongs_to :gpr_header
  belongs_to :gal_block
  belongs_to :oligo_sequence
  belongs_to :experiment


  def gpr_code
      Microarraygpr.find(microarraygpr_id).verbose_me
  end

  def upload_date
      self.created_at.to_s
  end

  def oligoId
      self.oligo_id
  end

  def oligo
      self.oligo_name
  end

  def array_info
        "Block:" + "<b>" + self.gal_block_id.to_s + "</b>" + "-" + "Row:" + "<b>" + self.oligo_row.to_s + "</b>" + "-" + "Column:" + "<b>" + self.oligo_column.to_s + "</b>" + "-" + "Oligo:" + "<b>" + self.oligo_name + "</b>" #+ "-" +"ID:" + self.oligo_id 
  end 

  
  attr_reader :show_array
  def show_array
        "Block:" + self.gal_block_id.to_s + "-" + "Row:" + self.oligo_row.to_s + "-" + "Column:" + self.oligo_column.to_s
  end



  def edit
        #include ActionController::UrlWriter 
        #if auth_sample_user(self.id) or signed_in_and_master?
        "<a href='" + edit_gpr_data_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
        #else
        #    ""
        #end
    end

    def act
        "<a href='" + gpr_data_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end




end
