class Experiment < ActiveRecord::Base

 include ActionController::UrlWriter
 include ExperimentHelper


  #validates_presence_of :filter_sample_id, :message => "Can't be empty, field is mandatory. "
  #validates_presence_of :microarraygal_id, :message => "Can't be empty, field is mandatory. "
  #validates_presence_of :micro_array_id, :message => "Can't be empty, field is mandatory. "
  #validates_presence_of :galTitle, :message => "This field is required to create new microarray experiment. Please upload gal file first."

  validates_presence_of :partner

  belongs_to :filter_sample

  belongs_to :oligo_sequence
  
  belongs_to :partner
  
  belongs_to :microarraygal

  has_many :oligos, :through => :microarraygals, :source => "microarraygal_id"
 
  belongs_to :person
  
  belongs_to :partner_person


  attr_reader :verbose_me
  def verbose_me
   return self.id.to_s + '-' +  self.ecode  + '-' + self.barcode  + '-' + self.experiment_date.to_s
  end
  
  def edit
        #include ActionController::UrlWriter 
        #if auth_sample_user(self.id) or signed_in_and_master?
        "<a href='" + edit_experiment_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
        #else
        #    ""
        #end
    end

    def act
        "<a href='" + experiment_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end

    
    def filter_name
        return FilterSample.find(filter_sample_id).code
    end

    def partner_name
       return Partner.find(partner_id).verbose_me
    end

    def gal_code
        return Microarraygal.find(microarraygal_id).verbose_me
    end

    def exp_date
        return self.experiment_date.to_s
    end

    def exp_code
        return self.ecode
    end
    
   


end
