#  create_table "water_samples", :force => true do |t|
#    t.string   "code", :null => false
#    t.integer  "temperature",  :limit => 10, :precision => 10, :scale => 0
#    t.integer  "turbidity",    :limit => 10, :precision => 10, :scale => 0
#    t.integer  "conductivity", :limit => 10, :precision => 10, :scale => 0
#    t.integer  "phosphates",   :limit => 10, :precision => 10, :scale => 0
#    t.integer  "nitrates",     :limit => 10, :precision => 10, :scale => 0
#    t.integer  "volume",       :limit => 10, :precision => 10, :scale => 0
#    t.integer  "ph",           :limit => 10, :precision => 10, :scale => 0
#    t.integer  "sampling_id", :null => false
#    t.datetime "samplingDate", :null => false
#    t.text     "note"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end

class WaterSample < ActiveRecord::Base
  validates_presence_of :code
  #http://ar.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html#M000087
  validates_uniqueness_of :code, :case_sensitive => false
  validates_length_of :code, :maximum=>19
  #, :scope => :water_sample_id --> kappao undefined method `water_samples_id'

  validates_numericality_of :temperature, :allow_nil => true, :less_than => 100
  validates_numericality_of :turbidity, :allow_nil => true, :less_than => 100
  validates_numericality_of :conductivity, :allow_nil => true, :less_than => 100
  validates_numericality_of :phosphates, :allow_nil => true, :less_than => 100
  validates_numericality_of :nitrates, :allow_nil => true, :less_than => 100
  validates_numericality_of :volume, :allow_nil => true, :less_than => 100
  validates_numericality_of :ph, :allow_nil => true, :less_than => 14

  #name of the model in lowercase
  belongs_to :sampling #, :null => false
  validates_presence_of :sampling

  #We don't need to call destroy method of child so use delete_all directly
  has_many :wfilter, :dependent => :delete_all
  has_many :protocol, :dependent => :delete_all

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.code + ' ' + self.samplingDate.to_s
  end

end

