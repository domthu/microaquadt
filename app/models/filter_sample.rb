#  create_table "filter_samples", :force => true do |t|

#  end

class FilterSample < ActiveRecord::Base
  validates_presence_of :code
  #http://ar.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html#M000087
  validates_uniqueness_of :code, :case_sensitive => false
  validates_length_of :code, :maximum=>19
  #, :scope => :filter_sample_id --> kappao undefined method `filter_samples_id'

  validates_numericality_of :temperature, :allow_nil => true, :less_than => 100
#  validates_numericality_of :turbidity, :allow_nil => true, :less_than => 100
  validates_numericality_of :conductivity, :allow_nil => true, :less_than => 100
  validates_numericality_of :phosphates, :allow_nil => true, :less_than => 100
  validates_numericality_of :nitrates, :allow_nil => true, :less_than => 100
  validates_numericality_of :ph, :allow_nil => true, :less_than => 14

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
    return self.pore_size.to_s + ' ' + self.num_filters.to_s + ' ' + self.volume.to_s
  end

end

