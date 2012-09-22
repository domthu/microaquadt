class Microarraygal < ActiveRecord::Base

include ActionController::UrlWriter
 include ExperimentHelper

  validates_presence_of :gal_title, :message => "Can't be empty, field is mandatory. "
  validates_presence_of :gal_file_title, :message => "Can't be empty, field is mandatory. "
  validates_presence_of :gal_file, :message => "Can't be empty, field is mandatory. "

  
  has_one :experiment
  belongs_to :partner
  has_many :oligos, :dependent => :destroy
  has_one :gal_header, :dependent => :destroy
  has_many :gal_blocks, :dependent => :destroy

  attr_reader :verbose_me
  def verbose_me
    just_filename = File.basename(path) 
      if just_filename =~ /(^\d+)?\s.+$/
        file_part = $1
      end
      if barcode.nil?
            self.id.to_s + '_' +  self.code  + '_' + file_part.to_s
        else
            return self.id.to_s + '_' +  self.code  + '_' + self.barcode  + '_' + file_part.to_s
        end   
  end


  attr_reader :path
  def path
    return File.join(self.gal_file_title, self.gal_title) 
  end


  def edit
        #include ActionController::UrlWriter 
        #if auth_sample_user(self.id) or signed_in_and_master?
        "<a href='" + edit_microarraygal_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
        #else
        #    ""
        #end
    end

    def act
        "<a href='" + microarraygal_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end

    def gal_f_code
        self.verbose_me
    end

    def partner_name
        Partner.find(partner_id).verbose_me
    end

    def title
        self.gal_title
    end

    def gal_upload_date
        self.loaded_at.to_s
    end

    def bcode
        self.barcode
    end
    
      
end  
