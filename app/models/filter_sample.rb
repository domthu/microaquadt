#  create_table "filter_samples", :force => true do |t|

#  end

class FilterSample < ActiveRecord::Base

  include ActionController::UrlWriter

  #Filter active record  
  named_scope :created_after, lambda { |date| {:conditions => ["samplingDate > ?", date]} }
  named_scope :created_at, lambda { |date| {:conditions => ["samplingDate = ?", date]} }
  named_scope :coded, lambda { |name| {:conditions => {:code => name}} }
  
  


  validates_presence_of :code, :message => "Can't be empty, field is mandatory. "

  #http://ar.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html#M000087
  validates_uniqueness_of :code, :case_sensitive => false
  validates_length_of :code, :maximum=>19
  #, :scope => :filter_sample_id --> kappao undefined method `filter_samples_id'

  validates_presence_of :volume, :message => "Can't be empty, field is mandatory. "

  validates_numericality_of :volume, :allow_nil => false, :less_than => 100
  validates_presence_of :num_filters, :message => "Can't be empty, field is mandatory. "
  validates_numericality_of :num_filters, :allow_nil => false, :less_than => 100, :greater_than => 0

  #name of the model in lowercase
  belongs_to :sampling #, :class_name => 'Sampling' #, :null => false
#  has_one :sampling_site, :through => :sampling
#Mysql::Error: Unknown column 'sampling_sites_filter_samples_join.sampling_id' in 'on clause': SELECT `filter_samples`.* FROM `filter_samples`   INNER JOIN `samplings` ON `samplings`.id = `filter_samples`.sampling_id  INNER JOIN `wfilters` ON `wfilters`.id = `filter_samples`.wfilter_id  INNER JOIN `samplings` sampling_sites_filter_samples_join ON (`filter_samples`.`id` = `sampling_sites_filter_samples_join`.`sampling_id`)  INNER JOIN `sampling_sites` ON (`sampling_sites`.`id` = `sampling_sites_filter_samples_join`.`sampling_site_id`)   LIMIT 0, 20
#  belongs_to :sampling_site, :include => :sampling
#Mysql::Error: Unknown column 'filter_samples.sampling_site_id' in 'on clause': SELECT `filter_samples`.* FROM `filter_samples`   INNER JOIN `samplings` ON `samplings`.id = `filter_samples`.sampling_id  INNER JOIN `wfilters` ON `wfilters`.id = `filter_samples`.wfilter_id  INNER JOIN `sampling_sites` ON `sampling_sites`.id = `filter_samples`.sampling_site_id   LIMIT 0, 20
#    belongs_to :sampling_site, :through => :sampling
#Unknown key(s): through


  #used for NESTED Model
  #validates_presence_of :sampling

  #We don't need to call destroy method of child so use delete_all directly
  #has_many :wfilters, :dependent => :delete_all
  belongs_to :wfilter #, :null => false
  validates_presence_of :wfilter

  has_one :filter_sample_preparations#, :null => true

  #20120201 add table nucleic acid
  has_many :nucleic_acids

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    #deprecated field self.pore_size   
    #return self.pore_size.to_s + ' - ' + self.num_filters.to_s + ' - ' + self.volume.to_s
    #return self.filter_pore_size + ' - ' + self.num_filters.to_s + ' - ' + self.volume.to_s
    return self.filter_name + ' - ' + self.num_filters.to_s + ' - ' + self.volume.to_s

  end

    def edit
        #include ActionController::UrlWriter
        #if  auth_sample_user(self.sampling_id) or signed_in_and_master?
        #if current_user? #undefined local variable or method `current_user' for #<Sampling:0xb6bc93bc>
        #if self.correct_user
        "<a href='" + edit_filter_sample_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
#        else
#            ""
#        end
    end

    def act
        "<a href='" + filter_sample_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end


    attr_reader :sample_name
    def sample_name
        Sampling.find(sampling_id).verbose_me
    end

    def cod_name
        if barcode.nil?
            code
        else
            barcode
        end
    end

    def full_name
        if barcode.nil?
            code + '  ' + verbose_me
        else
            code + '  ' + barcode + '  ' + verbose_me
        end
    end

    def partner_name
       Sampling.find(sampling_id).partner_name
    end

    def filter_name
        Wfilter.find(wfilter_id).verbose_me
    end

    def filter_pore_size
        Wfilter.find(wfilter_id).pore_size.to_s
    end

end

