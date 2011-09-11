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

ActiveRecord::Schema.define(:version => 20110911150557) do

  create_table "code_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "geos", :force => true do |t|
    t.string   "name"
    t.integer  "lon",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "lat",        :limit => 10, :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "land_use_mappings", :force => true do |t|
    t.string   "name"
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

  create_table "partner_people", :force => true do |t|
    t.integer  "partners_id"
    t.integer  "persons_id"
    t.boolean  "IsPrincipalInvestigator"
    t.boolean  "IsAdministratorResponsable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partners", :force => true do |t|
    t.integer  "fp7_Number"
    t.string   "Name"
    t.string   "State"
    t.text     "Address"
    t.string   "Phone"
    t.string   "Email"
    t.string   "Site"rmation) that was performed earlier
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "firstname"
    t.string   "LastName"
    t.string   "Phone"
    t.string   "Email"
    t.string   "Town"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "protocols", :force => true do |t|
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
    t.string   "Code"
    t.integer  "water_types_id"
    t.integer  "water_uses_id"
    t.integer  "geos_id"
    t.string   "geos_type",      :default => "Site"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "water_samples", :force => true do |t|
    t.integer  "Temperature",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "Turbidity",               :limit => 10, :precision => 10, :scale => 0
    t.integer  "Conductivity",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "Ph",                      :limit => 10, :precision => 10, :scale => 0
    t.string   "Code"
    t.integer  "meteorological_datas_id"
    t.integer  "water_types_id"
    t.integer  "water_uses_id"
    t.integer  "partners_id"
    t.integer  "land_use_mappings_id"
    t.integer  "sampling_sites_id"
    t.integer  "geos_id"
    t.string   "geos_type",                                                            :default => "Water"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "water_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "water_uses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
