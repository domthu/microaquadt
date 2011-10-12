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

ActiveRecord::Schema.define(:version => 20111008221923) do

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

  create_table "micro_array_analysis_files", :force => true do |t|
    t.integer  "microarray_id"
    t.text     "note"
    t.string   "MIANE_Standard"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "micro_array_analysis_files", ["microarray_id"], :name => "index_micro_array_analysis_files_on_microarray_id"

  create_table "micro_array_datas", :force => true do |t|
    t.integer  "microarray_id"
    t.text     "note"
    t.integer  "D_Index",                  :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Array_Row",              :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Array_Column",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Spot_Row",               :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Spot_Column",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Name",                   :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_ID",                     :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_X",                      :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Y",                      :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Diameter",               :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_F_Pixels",               :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_B_Pixels",               :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Footprint",              :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Flags",                  :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_Median",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_Mean",               :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_SD",                 :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_B_Median",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_B_Mean",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_B_SD",               :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_B_1_SD",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_B_2_SD",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_F_Sat",              :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_Median_B",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_Mean_B",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_SignalNoiseRatio",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_Median",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_Mean",               :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_SD",                 :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_B_Median",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_B_Mean",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_B_SD",               :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_B_1_SD",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_B_2_SD",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_F_Sat",              :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_Median_B",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_Mean_B",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_SignalNoiseRatio",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_Ratio_of_Medians",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_Ratio_of_Means",     :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_Median_of_Ratios",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_Mean_of_Ratios",     :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_Ratios_SD",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_Rgn_Ratio",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_Rgn_R",              :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_Log_Ratio",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Sum_of_Medians",         :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Sum_of_Means",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_N_Median",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_N_Mean",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_N_MedianB",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch1_N_MeanB",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_N_Median",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_N_Mean",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_N_MedianB",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_N_MeanB",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_N_Ratio_of_Medians", :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_N_Ratio_of_Means",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_N_Median_of_Ratios", :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_N_Mean_of_Ratios",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_N_Rgn_Ratio",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "D_Ch2_N_Log_Ratio",        :limit => 10, :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "micro_array_datas", ["microarray_id"], :name => "index_micro_array_datas_on_microarray_id"

  create_table "micro_array_images", :force => true do |t|
    t.integer  "microarray_id"
    t.text     "note"
    t.string   "name"
    t.binary   "image"
    t.integer  "II_ImageID"
    t.string   "II_Channel"
    t.string   "II_Image"
    t.string   "II_Fluorophore"
    t.string   "II_Barcode"
    t.string   "II_Units"
    t.integer  "II_X_Units_Per_Pixel", :limit => 10, :precision => 10, :scale => 0
    t.integer  "II_Y_Units_Per_Pixel", :limit => 10, :precision => 10, :scale => 0
    t.integer  "II_X_Offset",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "II_Y_Offset",          :limit => 10, :precision => 10, :scale => 0
    t.string   "II_Status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "micro_array_images", ["microarray_id"], :name => "index_micro_array_images_on_microarray_id"

  create_table "micro_array_validations", :force => true do |t|
    t.integer  "microarray_id"
    t.text     "note"
    t.integer  "CellCount",     :limit => 10, :precision => 10, :scale => 0
    t.integer  "QPCR_decimal",  :limit => 10, :precision => 10, :scale => 0
    t.integer  "QPCR_Culture",  :limit => 10, :precision => 10, :scale => 0
    t.integer  "Chemscan",      :limit => 10, :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "micro_array_validations", ["microarray_id"], :name => "index_micro_array_validations_on_microarray_id"

  create_table "micro_arrays", :force => true do |t|
    t.string   "gpr_title"
    t.string   "gpr_file_title"
    t.binary   "gpr_file"
    t.text     "note"
    t.date     "loaded_at"
    t.integer  "partner_id"
    t.string   "H_name"
    t.integer  "H_ScanArrayCSVFileFormat",         :limit => 10, :precision => 10, :scale => 0
    t.integer  "H_ScanArray_Express",              :limit => 10, :precision => 10, :scale => 0
    t.integer  "H_Number_of_Columns"
    t.datetime "I_DateTime"
    t.string   "I_GalFile"
    t.string   "I_Scanner"
    t.string   "I_User_Name"
    t.string   "I_Computer_Name"
    t.string   "I_Protocol"
    t.string   "I_Quantitation_Method"
    t.string   "I_Quality_Confidence_Calculation"
    t.text     "I_User_comments"
    t.string  "I_Image_Origin",
    t.integer  "I_Temperature",                    :limit => 10, :precision => 10, :scale => 0
    t.string   "I_Laser_Powers"
    t.integer  "I_Laser_On_Time",                  :limit => 10, :precision => 10, :scale => 0
    t.string   "I_PMT_Voltages"
    t.integer  "QP_Min_Percentile"
    t.integer  "QP_Max_Percentile"
    t.integer  "QM_Max_Footprint"
    t.string   "API_Units"
    t.integer  "API_Array_Rows"
    t.integer  "API_Array_Columns"
    t.integer  "API_Spot_Rows"
    t.integer  "API_Spot_Columns"
    t.integer  "API_Array_Row_Spacing",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "API_Array_Column_Spacing",         :limit => 10, :precision => 10, :scale => 0
    t.integer  "API_Spot_Row_Spacing",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "API_Spot_Column_Spacing",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "API_Spot_Diameter"
    t.integer  "API_Interstitial"
    t.integer  "API_Spots_Per_Array"
    t.integer  "API_Total_Spots"
    t.string   "NI_Normalization_Method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "micro_arrays", ["partner_id"], :name => "index_micro_arrays_on_partner_id"

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
    t.integer  "rank",       :limit => 10, :precision => 10, :scale => 0
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

  create_table "operations", :force => true do |t|
    t.integer  "protocol_id"
    t.string   "name"
    t.integer  "step"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "operations", ["protocol_id"], :name => "index_operations_on_protocol_id"

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
    t.integer  "sampling_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "protocols", ["sampling_id"], :name => "index_protocols_on_sampling_id"

  create_table "sampling_sites", :force => true do |t|
    t.string   "code",                                                                                  :null => false
    t.string   "name"
    t.string   "aptitudeTypology"
    t.string   "catchmentArea"
    t.string   "geology"
    t.string   "depth"
    t.string   "sizeTypology"
    t.integer  "salinity",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "tidalRange",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "water_types_id",                                                                        :null => false
    t.integer  "water_uses_id",                                                                         :null => false
    t.integer  "land_use_mappings_id",                                                                  :null => false
    t.integer  "country_id",                                                                            :null => false
    t.integer  "geos_id"
    t.string   "geos_type",                                                         :default => "Site"
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
    t.string   "code",                                                          :null => false
    t.integer  "temperature",      :limit => 10, :precision => 10, :scale => 0
    t.integer  "moisture",         :limit => 10, :precision => 10, :scale => 0
    t.integer  "pressure",         :limit => 10, :precision => 10, :scale => 0
    t.integer  "windSpeed",        :limit => 10, :precision => 10, :scale => 0
    t.string   "windDirection"
    t.integer  "waterFlow",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "lightIntensity",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "rainfallEvents",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "depth",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "turbidity",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "sampling_site_id",                                              :null => false
    t.integer  "partner_id",                                                    :null => false
    t.datetime "samplingDate",                                                  :null => false
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
    t.string   "code",                                                      :null => false
    t.integer  "temperature",  :limit => 10, :precision => 10, :scale => 0
    t.integer  "turbidity",    :limit => 10, :precision => 10, :scale => 0
    t.integer  "conductivity", :limit => 10, :precision => 10, :scale => 0
    t.integer  "phosphates",   :limit => 10, :precision => 10, :scale => 0
    t.integer  "nitrates",     :limit => 10, :precision => 10, :scale => 0
    t.integer  "volume",       :limit => 10, :precision => 10, :scale => 0
    t.integer  "ph",           :limit => 10, :precision => 10, :scale => 0
    t.integer  "sampling_id",                                               :null => false
    t.datetime "samplingDate",                                              :null => false
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

