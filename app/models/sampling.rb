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

include ActionController::UrlWriter
include SamplingsHelper

  validates_presence_of :code
  validates_uniqueness_of :code, :case_sensitive => false
  validates_length_of :code, :maximum=>15
  #, :scope => :sampling_id --> kappao undefined method `samplingS_id'

  validates_presence_of :volume
  validates_numericality_of :volume, :less_than => 100

  validates_numericality_of :air_temperature, :allow_nil => true, :less_than => 100
  validates_numericality_of :water_temperature, :allow_nil => true, :less_than => 100
  validates_numericality_of :moisture, :allow_nil => true, :less_than => 100
  validates_numericality_of :pressure, :allow_nil => true, :less_than => 100
  validates_numericality_of :windSpeed, :allow_nil => true, :less_than => 100
  validates_numericality_of :waterFlow, :allow_nil => true, :less_than => 100
  validates_numericality_of :lightIntensity, :allow_nil => true, :less_than => 100
  validates_numericality_of :rainfallEvents, :allow_nil => true, :less_than => 100
  validates_numericality_of :depth, :allow_nil => true, :less_than => 100
  validates_numericality_of :turbidity, :allow_nil => true, :less_than => 100
  validates_numericality_of :salinity, :less_than => 100
  validates_numericality_of :tidalRange, :less_than => 100
  validates_numericality_of :conductivity, :allow_nil => true, :less_than => 100
  validates_numericality_of :phosphates, :allow_nil => true, :less_than => 100
  validates_numericality_of :nitrates, :allow_nil => true, :less_than => 100
  validates_numericality_of :ph, :allow_nil => true, :less_than => 14

  validates_numericality_of :nitrogen, :allow_nil => true, :less_than => 100
  validates_numericality_of :bod5, :allow_nil => true, :less_than => 100
  validates_numericality_of :cod, :allow_nil => true, :less_than => 100
  validates_numericality_of :h2osat, :allow_nil => true, :less_than => 100

  #name of the model in lowercase
  belongs_to :sampling_site  #, :null => false
  belongs_to :partner  #, :null => false  --> Unknown key(s): null
  #belongs_to :wfilter
  validates_presence_of :sampling_site
  validates_presence_of :partner

  #COLLECTION:
  #     Firm#clients (similar to Clients.find :all, :conditions =&gt; [&quot;firm_id = ?&quot;, id])
  #:dependent => :delete_all vs :destroy (call destroy children event)
  has_many :filter_samples, :dependent => :destroy
  has_many :protocols, :dependent => :delete_all
  #has_many :relationships, :class_name => 'Relationship', :finder_sql => %q(
  #  SELECT DISTINCT relationships.*
  #  FROM relationships
  #  WHERE contact_id = #{id}
  #)

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    #return self.code + ' ' + self.samplingDate.to_s # + partner.verbose_me
    #return self.name + ' ' + self.samplingDate.strftime("%y%m%d")
    return self.code  + ' ' + self.sampling_site.code  + ' ' + self.volume.to_s + 'L'
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


    def edit
        #include ActionController::UrlWriter 
        #if auth_sample_user(self.id) or signed_in_and_master?
        "<a href='" + edit_sampling_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
        #else
        #    ""
        #end
    end

    def act
        "<a href='" + sampling_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end

    def site_name
        SamplingSite.find(sampling_site_id).verbose_me
    end

    def partner_name
        Partner.find(partner_id).verbose_me
    end

end

