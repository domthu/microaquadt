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

ActiveRecord::Schema.define(:version => 20110919091627) do

  create_table "code_types", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filters", :force => true do |t|
    t.string   "name",       :null => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "geos", :force => true do |t|
    t.string   "name",                                                    :null => false
    t.integer  "lon",        :limit => 10, :precision => 10, :scale => 0, :null => false
    t.integer  "lat",        :limit => 10, :precision => 10, :scale => 0, :null => false
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
    t.integer  "Temperature",    :limit => 10, :precision => 10, :scale => 0
    t.integer  "Moisture",       :limit => 10, :precision => 10, :scale => 0
    t.integer  "Pressure",       :limit => 10, :precision => 10, :scale => 0
    t.integer  "WindSpeed",      :limit => 10, :precision => 10, :scale => 0
    t.string   "WindDirection"
    t.integer  "WaterFlow",      :limit => 10, :precision => 10, :scale => 0
    t.integer  "LightIntensity", :limit => 10, :precision => 10, :scale => 0
    t.integer  "RainfallEvents", :limit => 10, :precision => 10, :scale => 0
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
    t.string   "name",       :null => false
    t.string   "state",      :null => false
    t.text     "address"
    t.string   "phone"
    t.string   "email",      :null => false
    t.string   "site"
    t.binary   "logo"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "partners", ["email"], :name => "index_partners_on_email", :unique => true
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
    t.text     "alueDefinition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sampling_sites", :force => true do |t|
    t.string   "code",                                                                                  :null => false
    t.string   "name"
    t.string   "country"
    t.string   "aptitudeTypology"
    t.string   "catchmentArea"
    t.string   "geology"
    t.string   "depth"
    t.string   "sizeTypology"
    t.integer  "salinity",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "tidalRange",           :limit => 10, :precision => 10, :scale => 0
    t.string   "otherInformation"
    t.integer  "water_types_id"
    t.integer  "water_uses_id"
    t.integer  "land_use_mappings_id"
    t.integer  "geos_id"
    t.string   "geos_type",                                                         :default => "Site"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sampling_sites", ["geos_id"], :name => "index_sampling_sites_on_geos_id"
  add_index "sampling_sites", ["land_use_mappings_id"], :name => "index_sampling_sites_on_land_use_mappings_id"
  add_index "sampling_sites", ["water_types_id"], :name => "index_sampling_sites_on_water_types_id"
  add_index "sampling_sites", ["water_uses_id"], :name => "index_sampling_sites_on_water_uses_id"

  create_table "samplings", :force => true do |t|
    t.string   "code"
    t.integer  "temperature",      :limit => 10, :precision => 10, :scale => 0
    t.integer  "moisture",         :limit => 10, :precision => 10, :scale => 0
    t.integer  "pressure",         :limit => 10, :precision => 10, :scale => 0
    t.integer  "windSpeed",        :limit => 10, :precision => 10, :scale => 0
    t.string   "windDirection"
    t.integer  "waterFlow",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "lightIntensity",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "rainfallEvents",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "depth",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "sampling_site_id"
    t.integer  "partner_id"
    t.integer  "wfilter_id"
    t.datetime "samplingDate"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "samplings", ["partner_id"], :name => "index_samplings_on_partner_id"
  add_index "samplings", ["sampling_site_id"], :name => "index_samplings_on_sampling_site_id"
  add_index "samplings", ["wfilter_id"], :name => "index_samplings_on_filter_id"

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
    t.string   "code",                                                      :null => false
    t.integer  "temperature",  :limit => 10, :precision => 10, :scale => 0
    t.integer  "turbidity",    :limit => 10, :precision => 10, :scale => 0
    t.integer  "conductivity", :limit => 10, :precision => 10, :scale => 0
    t.integer  "phosphates",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "nitrates",     :limit => 10, :precision => 10, :scale => 0
    t.integer  "volume",       :limit => 10, :precision => 10, :scale => 0
    t.integer  "ph",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "samplings_id"
    t.datetime "samplingDate"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "water_samples", ["samplings_id"], :name => "index_water_samples_on_samplings_id"

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
