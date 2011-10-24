# create_table "sampling_sites", :force => true do |t|
#    t.string   "code", :null => false                                                                                  :null => false
#    t.string   "name", :null => false
#    t.string   "country"
#    t.string   "aptitudeTypology"
#    t.string   "catchmentArea"
#    t.string   "geology"
#    t.string   "depth"
#    t.string   "sizeTypology"
#    t.integer  "salinity",  :limit => 10, :precision => 10, :scale => 0
#    t.integer  "tidalRange", :limit => 10, :precision => 10, :scale => 0
#    t.string   "otherInformation"
#    t.integer  "water_types_id"
#    t.integer  "water_uses_id"
#    t.integer  "land_use_mappings_id"
#    t.integer  "geos_id"
#    t.string   "geos_type", :default => "Site"
#    t.text     "note"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
class SamplingSite < ActiveRecord::Base

include ActionController::UrlWriter




  #validates_presence_of :code, :water_type, :water_use, :geo
  validates_presence_of :code
  validates_uniqueness_of :code, :case_sensitive => false
  #, :scope => :sampling_sites_id  --> Kappao undefined method `sampling_sites_id'

  #Rails used to have a country_select helper for choosing countries,
  #but this has been extracted to the country_select plugin.

  validates_numericality_of :salinity, :less_than => 100
  validates_numericality_of :tidalRange, :less_than => 100

  #name of the model in lowercase
  belongs_to :water_type
  #has_one :water_use in this case WaterUse will have field sampling_site_id
  belongs_to :water_use  #In this case SamplingSite have field water_uses_id
  belongs_to :geo
  has_one :land_use_mapping
  has_one :country
  has_many :samplings, :dependent => :destroy

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.code + ' ' + self.name
  end

    def formatted_created_at
        created_at.strftime("%Y-%m-%d")
    end

    def capitalized_name
        name.capitalize
    end

    def country_name
        Country.find(country_id).name
    end

    def geo_name
        Geo.find(geos_id).name
    end

    def land_name
        LandUseMapping.find(land_use_mappings_id).name
    end

    def w_type_name
        WaterType.find(water_types_id).name
    end

    def w_use_name
        WaterUse.find(water_uses_id).name
    end
#    <td><%=h WaterUse.find(sampling_site.water_uses_id).name %></td>
#    <td><%=h WaterType.find(sampling_site.water_types_id).name %></td>
#    <td><%=h LandUseMapping.find(sampling_site.land_use_mappings_id).name %></td>
#    <td><%=h Geo.find(sampling_site.geos_id).name %></td>
#    <td><%=h Country.find(sampling_site.country_id).name %></td>

    def edit
        #edit_sampling_site_path(self)  --> Kappao _path() is an undefined method inside Model code
        #include ActionController::UrlWriter
        #link_to "edit", edit_sampling_site_path(self)
        "<a href='" + edit_sampling_site_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
    end

    def act
        "<a href='" + sampling_site_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end
end

