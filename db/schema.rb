# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111006071011) do

  create_table "code_types", :force => true do |t|
    t.string   "code",       :null => false
    t.string   "name",       :null => false
    t.integer  "partner_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "code_types", ["partner_id"], :name => "index_code_types_on_partner_id"

  create_table "comments", :force => true do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "geos", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "lon",        :null => false
    t.integer  "lat",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "land_use_mappings", :force => true do |t|
    t.string   "name",       :null => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meteorological_datas", :force => true do |t|
    t.integer  "Temperature"
    t.integer  "Moisture"
    t.integer  "Pressure"
    t.integer  "WindSpeed"
    t.string   "WindDirection"
    t.integer  "WaterFlow"
    t.integer  "LightIntensity"
    t.integer  "RainfallEvents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "micro_arra_analysis_files", :force => true do |t|
    t.integer  "microarraydata_id"
    t.text     "info"
    t.string   "MIANE_Standard"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "micro_array_datas", :force => true do |t|
    t.string   "gpr_title"
    t.string   "gpr_file_title"
    t.binary   "gpr_file"
    t.text     "comment_text"
    t.date     "loaded_at"
    t.integer  "partner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "micro_array_images", :force => true do |t|
    t.integer  "microarraydata_id"
    t.string   "name"
    t.binary   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "micro_array_validations", :force => true do |t|
    t.integer  "microarraydata_id"
    t.integer  "CellCount",         :limit => 10, :precision => 10, :scale => 0
    t.integer  "QPCR_decimal",      :limit => 10, :precision => 10, :scale => 0
    t.integer  "QPCR_Culture",      :limit => 10, :precision => 10, :scale => 0
    t.integer  "Chemscan",          :limit => 10, :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "names", :force => true do |t|
    t.integer  "tax_id"
    t.string   "name_txt"
    t.string   "unique_name"
    t.string   "name_class"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "names", ["name_txt"], :name => "index_names_on_name_txt"
  add_index "names", ["tax_id"], :name => "index_names_on_tax_id"

  create_table "nodes", :force => true do |t|
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oligo_sequences", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "partner_id",   :null => false
    t.string   "DNA_Sequence"
    t.integer  "tax_id_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oligo_sequences", ["partner_id"], :name => "index_oligo_sequences_on_partner_id"

  create_table "partner_people", :force => true do |t|
    t.integer  "partner_id"
    t.integer  "person_id"
    t.boolean  "IsPrincipalInvestigator"
    t.boolean  "IsAdministratorResponsable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "partner_people", ["partner_id"], :name => "index_partner_people_on_partner_id"
  add_index "partner_people", ["person_id"], :name => "index_partner_people_on_person_id"

  create_table "partners", :force => true do |t|
    t.integer  "fp7_Number", :null => false
    t.string   "code",       :null => false
    t.string   "name",       :null => false
    t.text     "address"
    t.string   "phone"
    t.string   "email",      :null => false
    t.string   "site"
    t.binary   "logo"
    t.integer  "user_id",    :null => false
    t.integer  "country_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "partners", ["email"], :name => "index_partners_on_email", :unique => true
  add_index "partners", ["name"], :name => "index_partners_on_name", :unique => true
  add_index "partners", ["user_id"], :name => "index_partners_on_user_id"

  create_table "people", :force => true do |t|
    t.string   "firstname",  :null => false
    t.string   "LastName",   :null => false
    t.string   "Phone"
    t.string   "email",      :null => false
    t.string   "Town"
    t.binary   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["email"], :name => "index_people_on_email", :unique => true

  create_table "posts", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "title",      :null => false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "protocols", :force => true do |t|
    t.string   "name",              :null => false
    t.text     "GrowthProtocol"
    t.text     "TreatmentProtocol"
    t.text     "ExtractProtocol"
    t.text     "LabelProtocol"
    t.text     "HybProtocol"
    t.text     "ScanProtocol"
    t.text     "DataProcessing"
    t.text     "ValueDefinition"
    t.integer  "water_sample_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "protocols", ["water_sample_id"], :name => "index_protocols_on_water_sample_id"

  create_table "sampling_sites", :force => true do |t|
    t.string   "code",                                     :null => false
    t.string   "name"
    t.string   "aptitudeTypology"
    t.string   "catchmentArea"
    t.string   "geology"
    t.string   "depth"
    t.string   "sizeTypology"
    t.integer  "salinity"
    t.integer  "tidalRange"
    t.integer  "water_types_id",                           :null => false
    t.integer  "water_uses_id",                            :null => false
    t.integer  "land_use_mappings_id",                     :null => false
    t.integer  "country_id",                               :null => false
    t.integer  "geos_id"
    t.string   "geos_type",            :default => "Site"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sampling_sites", ["country_id"], :name => "index_sampling_sites_on_country_id"
  add_index "sampling_sites", ["geos_id"], :name => "index_sampling_sites_on_geos_id"
  add_index "sampling_sites", ["land_use_mappings_id"], :name => "index_sampling_sites_on_land_use_mappings_id"
  add_index "sampling_sites", ["water_types_id"], :name => "index_sampling_sites_on_water_types_id"
  add_index "sampling_sites", ["water_uses_id"], :name => "index_sampling_sites_on_water_uses_id"

  create_table "samplings", :force => true do |t|
    t.string   "code",             :null => false
    t.integer  "temperature"
    t.integer  "moisture"
    t.integer  "pressure"
    t.integer  "windSpeed"
    t.string   "windDirection"
    t.integer  "waterFlow"
    t.integer  "lightIntensity"
    t.integer  "rainfallEvents"
    t.integer  "depth"
    t.integer  "sampling_site_id", :null => false
    t.integer  "partner_id",       :null => false
    t.datetime "samplingDate",     :null => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "samplings", ["partner_id"], :name => "index_samplings_on_partner_id"
  add_index "samplings", ["sampling_site_id"], :name => "index_samplings_on_sampling_site_id"

  create_table "users", :force => true do |t|
    t.string   "name",               :null => false
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "water_samples", :force => true do |t|
    t.string   "code",         :null => false
    t.integer  "temperature"
    t.integer  "turbidity"
    t.integer  "conductivity"
    t.integer  "phosphates"
    t.integer  "nitrates"
    t.integer  "volume"
    t.integer  "ph"
    t.integer  "sampling_id",  :null => false
    t.datetime "samplingDate", :null => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "water_samples", ["sampling_id"], :name => "index_water_samples_on_sampling_id"

  create_table "water_types", :force => true do |t|
    t.string   "code",       :null => false
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "water_uses", :force => true do |t|
    t.string   "code",       :null => false
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wfilters", :force => true do |t|
    t.string   "name"
    t.text     "note"
    t.integer  "water_sample_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wfilters", ["water_sample_id"], :name => "index_wfilters_on_water_sample_id"

end
