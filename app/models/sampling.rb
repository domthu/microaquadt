#  create_table "samplings", :force => true do |t|
#    t.string   "code", :null => false
#    t.integer  "temperature",      :limit => 10, :precision => 10, :scale => 0
#    t.integer  "moisture",         :limit => 10, :precision => 10, :scale => 0
#    t.integer  "pressure",         :limit => 10, :precision => 10, :scale => 0
#    t.integer  "windSpeed",        :limit => 10, :precision => 10, :scale => 0
#    t.string   "windDirection"
#    t.integer  "waterFlow",        :limit => 10, :precision => 10, :scale => 0
#    t.integer  "lightIntensity",   :limit => 10, :precision => 10, :scale => 0
#    t.integer  "rainfallEvents",   :limit => 10, :precision => 10, :scale => 0
#    t.integer  "depth",            :limit => 10, :precision => 10, :scale => 0
#    t.integer  "sampling_site_id", :null => false
#    t.integer  "partner_id", :null => false
#    t.integer  "filter_id", :null => true
#    t.datetime "samplingDate", :null => false
#    t.text     "note"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end

class Sampling < ActiveRecord::Base
  validates_presence_of :code
  validates_uniqueness_of :code, :case_sensitive => false, :scope => :samplings_id

  validates_numericality_of :temperature, :less_than => 100
  validates_numericality_of :moisture, :less_than => 100
  validates_numericality_of :pressure, :less_than => 100
  validates_numericality_of :windSpeed, :less_than => 100
  validates_numericality_of :waterFlow, :less_than => 100
  validates_numericality_of :lightIntensity, :less_than => 100
  validates_numericality_of :rainfallEvents, :less_than => 100
  validates_numericality_of :depth, :less_than => 100

  #name of the model in lowercase
  belongs_to :sampling_site
  belongs_to :partner
  belongs_to :wfilter

  has_many :water_sample


  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.code + ' ' + self.samplingDate.to_s # + partner.verbose_me
  end
  #def Sampling.verbose_me
  #  @@verbose_me ||=  "Kappaooo "
  #end


#attr_reader :total_temperature
#def Sampling.total_temperature
#  @@total_temperature ||= Sampling.sum(:temperature)
#end
#memoize :total_temperature #Undefined method `memoize'

#attr_reader :handle #use as <%= f.text_field :handle %>
#def handle=(text)
#  if user = User.find_by_handle(text)
#    self.user = user
#  else
#    errors.add(:base, "User with the handle '#{text}' not found"
#  end
#end

##return first of matching products (id only to minimize memory consumption)
#def self.custom_find_by_name(product_name)
#  @@product_names ||= Product.all(:select=>'id, name')
#  @@product_names.select{|p| p.name.downcase == product_name.downcase}.first
#end
#remember a way to flush finder cache in case you run this from console
#def self.flush_custom_finder_cache!
#  @@product_names = nil
#end

end

