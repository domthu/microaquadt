#  create_table "filter_samples", :force => true do |t|

#  end

class FilterSample < ActiveRecord::Base

include ActionController::UrlWriter

  validates_presence_of :code
  #http://ar.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html#M000087
  validates_uniqueness_of :code, :case_sensitive => false
  validates_length_of :code, :maximum=>19
  #, :scope => :filter_sample_id --> kappao undefined method `filter_samples_id'

  validates_presence_of :volume
  validates_numericality_of :volume, :allow_nil => false, :less_than => 100
  validates_presence_of :num_filters
  validates_numericality_of :num_filters, :allow_nil => false, :less_than => 100, :greater_than => 0

  #name of the model in lowercase
  belongs_to :sampling #, :null => false
  validates_presence_of :sampling

  #We don't need to call destroy method of child so use delete_all directly
  #has_many :wfilters, :dependent => :delete_all
  belongs_to :wfilter #, :null => false
  validates_presence_of :wfilter

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.pore_size.to_s + ' - ' + self.num_filters.to_s + ' - ' + self.volume.to_s
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


    def sample_name
        Sampling.find(sampling_id).verbose_me
    end

    def code_name
        if barcode.nil?
            code
        else
            barcode
        end
    end

    def partner_name
       Sampling.find(sampling_id).partner_name
    end

    def filter_name
        Wfilter.find(wfilter_id).verbose_me
    end

end

