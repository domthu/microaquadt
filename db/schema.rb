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

ActiveRecord::Schema.define(:version => 20120116141436) do

  create_table "altitude_types", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "catchment_areas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

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

  create_table "depths", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "filter_sample_preparations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filter_samples", :force => true do |t|
    t.integer  "sampling_id",                                                                               :null => false
    t.datetime "samplingDate",                                                                              :null => false
    t.integer  "wfilter_id",                                                                                :null => false
    t.decimal  "pore_size",                                  :precision => 5, :scale => 3, :default => 0.0
    t.integer  "num_filters",                   :limit => 2,                               :default => 0
    t.decimal  "avg_qta",                                    :precision => 4, :scale => 2, :default => 0.0
    t.decimal  "volume",                                     :precision => 4, :scale => 2,                  :null => false
    t.string   "barcode",                                                                                   :null => false
    t.string   "code"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "storage"
    t.integer  "filter_sample_preparations_id"
  end

  add_index "filter_samples", ["sampling_id"], :name => "index_filter_samples_on_sampling_id"
  add_index "filter_samples", ["wfilter_id"], :name => "index_filter_samples_on_wfilter_id"

  create_table "geologies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "geos", :force => true do |t|
    t.string   "name",                                                       :null => false
    t.decimal  "lon",        :precision => 10, :scale => 8,                  :null => false
    t.decimal  "lat",        :precision => 10, :scale => 8,                  :null => false
    t.integer  "country_id",                                                 :null => false
    t.decimal  "width",      :precision => 8,  :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "geos", ["country_id"], :name => "index_geos_on_country_id"

  create_table "land_use_mappings", :force => true do |t|
    t.string   "name",       :null => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meteorological_datas", :force => true do |t|
    t.decimal  "Temperature",    :precision => 4, :scale => 2
    t.decimal  "Moisture",       :precision => 8, :scale => 2
    t.decimal  "Pressure",       :precision => 8, :scale => 2
    t.decimal  "WindSpeed",      :precision => 8, :scale => 2
    t.string   "WindDirection"
    t.decimal  "WaterFlow",      :precision => 8, :scale => 2
    t.decimal  "LightIntensity", :precision => 8, :scale => 2
    t.decimal  "RainfallEvents", :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "micro_array_analysis_files", :force => true do |t|
    t.integer  "microarray_id"
    t.text     "note"
    t.string   "MIANE_Standard"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "protocol"
    t.text     "consumables"
  end

  add_index "micro_array_analysis_files", ["microarray_id"], :name => "index_micro_array_analysis_files_on_microarray_id"

  create_table "micro_array_datas", :force => true do |t|
    t.integer  "microarray_id"
    t.text     "note"
    t.decimal  "D_Index",                  :precision => 8, :scale => 2
    t.decimal  "D_Array_Row",              :precision => 8, :scale => 2
    t.decimal  "D_Array_Column",           :precision => 8, :scale => 2
    t.decimal  "D_Spot_Row",               :precision => 8, :scale => 2
    t.decimal  "D_Spot_Column",            :precision => 8, :scale => 2
    t.decimal  "D_Name",                   :precision => 8, :scale => 2
    t.decimal  "D_ID",                     :precision => 8, :scale => 2
    t.decimal  "D_X",                      :precision => 8, :scale => 2
    t.decimal  "D_Y",                      :precision => 8, :scale => 2
    t.decimal  "D_Diameter",               :precision => 8, :scale => 2
    t.decimal  "D_F_Pixels",               :precision => 8, :scale => 2
    t.decimal  "D_B_Pixels",               :precision => 8, :scale => 2
    t.decimal  "D_Footprint",              :precision => 8, :scale => 2
    t.decimal  "D_Flags",                  :precision => 8, :scale => 2
    t.decimal  "D_Ch1_Median",             :precision => 8, :scale => 2
    t.decimal  "D_Ch1_Mean",               :precision => 8, :scale => 2
    t.decimal  "D_Ch1_SD",                 :precision => 8, :scale => 2
    t.decimal  "D_Ch1_B_Median",           :precision => 8, :scale => 2
    t.decimal  "D_Ch1_B_Mean",             :precision => 8, :scale => 2
    t.decimal  "D_Ch1_B_SD",               :precision => 8, :scale => 2
    t.decimal  "D_Ch1_B_1_SD",             :precision => 8, :scale => 2
    t.decimal  "D_Ch1_B_2_SD",             :precision => 8, :scale => 2
    t.decimal  "D_Ch1_F_Sat",              :precision => 8, :scale => 2
    t.decimal  "D_Ch1_Median_B",           :precision => 8, :scale => 2
    t.decimal  "D_Ch1_Mean_B",             :precision => 8, :scale => 2
    t.decimal  "D_Ch1_SignalNoiseRatio",   :precision => 8, :scale => 2
    t.decimal  "D_Ch2_Median",             :precision => 8, :scale => 2
    t.decimal  "D_Ch2_Mean",               :precision => 8, :scale => 2
    t.decimal  "D_Ch2_SD",                 :precision => 8, :scale => 2
    t.decimal  "D_Ch2_B_Median",           :precision => 8, :scale => 2
    t.decimal  "D_Ch2_B_Mean",             :precision => 8, :scale => 2
    t.decimal  "D_Ch2_B_SD",               :precision => 8, :scale => 2
    t.decimal  "D_Ch2_B_1_SD",             :precision => 8, :scale => 2
    t.decimal  "D_Ch2_B_2_SD",             :precision => 8, :scale => 2
    t.decimal  "D_Ch2_F_Sat",              :precision => 8, :scale => 2
    t.decimal  "D_Ch2_Median_B",           :precision => 8, :scale => 2
    t.decimal  "D_Ch2_Mean_B",             :precision => 8, :scale => 2
    t.decimal  "D_Ch2_SignalNoiseRatio",   :precision => 8, :scale => 2
    t.decimal  "D_Ch2_Ratio_of_Medians",   :precision => 8, :scale => 2
    t.decimal  "D_Ch2_Ratio_of_Means",     :precision => 8, :scale => 2
    t.decimal  "D_Ch2_Median_of_Ratios",   :precision => 8, :scale => 2
    t.decimal  "D_Ch2_Mean_of_Ratios",     :precision => 8, :scale => 2
    t.decimal  "D_Ch2_Ratios_SD",          :precision => 8, :scale => 2
    t.decimal  "D_Ch2_Rgn_Ratio",          :precision => 8, :scale => 2
    t.decimal  "D_Ch2_Rgn_R",              :precision => 8, :scale => 2
    t.decimal  "D_Ch2_Log_Ratio",          :precision => 8, :scale => 2
    t.decimal  "D_Sum_of_Medians",         :precision => 8, :scale => 2
    t.decimal  "D_Sum_of_Means",           :precision => 8, :scale => 2
    t.decimal  "D_Ch1_N_Median",           :precision => 8, :scale => 2
    t.decimal  "D_Ch1_N_Mean",             :precision => 8, :scale => 2
    t.decimal  "D_Ch1_N_MedianB",          :precision => 8, :scale => 2
    t.decimal  "D_Ch1_N_MeanB",            :precision => 8, :scale => 2
    t.decimal  "D_Ch2_N_Median",           :precision => 8, :scale => 2
    t.decimal  "D_Ch2_N_Mean",             :precision => 8, :scale => 2
    t.decimal  "D_Ch2_N_MedianB",          :precision => 8, :scale => 2
    t.decimal  "D_Ch2_N_MeanB",            :precision => 8, :scale => 2
    t.decimal  "D_Ch2_N_Ratio_of_Medians", :precision => 8, :scale => 2
    t.decimal  "D_Ch2_N_Ratio_of_Means",   :precision => 8, :scale => 2
    t.decimal  "D_Ch2_N_Median_of_Ratios", :precision => 8, :scale => 2
    t.decimal  "D_Ch2_N_Mean_of_Ratios",   :precision => 8, :scale => 2
    t.decimal  "D_Ch2_N_Rgn_Ratio",        :precision => 8, :scale => 2
    t.decimal  "D_Ch2_N_Log_Ratio",        :precision => 8, :scale => 2
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
    t.decimal  "II_X_Units_Per_Pixel", :precision => 8, :scale => 2
    t.decimal  "II_Y_Units_Per_Pixel", :precision => 8, :scale => 2
    t.decimal  "II_X_Offset",          :precision => 8, :scale => 2
    t.decimal  "II_Y_Offset",          :precision => 8, :scale => 2
    t.string   "II_Status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "micro_array_images", ["microarray_id"], :name => "index_micro_array_images_on_microarray_id"

  create_table "micro_array_validations", :force => true do |t|
    t.integer  "microarray_id"
    t.text     "note"
    t.decimal  "CellCount",     :precision => 8, :scale => 2
    t.decimal  "QPCR_decimal",  :precision => 8, :scale => 2
    t.decimal  "QPCR_Culture",  :precision => 8, :scale => 2
    t.decimal  "Chemscan",      :precision => 8, :scale => 2
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
    t.decimal  "H_ScanArrayCSVFileFormat",         :precision => 8, :scale => 2
    t.decimal  "H_ScanArray_Express",              :precision => 8, :scale => 2
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
    t.string   "I_Image_Origin"
    t.decimal  "I_Temperature",                    :precision => 4, :scale => 2
    t.string   "I_Laser_Powers"
    t.decimal  "I_Laser_On_Time",                  :precision => 8, :scale => 2
    t.string   "I_PMT_Voltages"
    t.integer  "QP_Min_Percentile"
    t.integer  "QP_Max_Percentile"
    t.integer  "QM_Max_Footprint"
    t.string   "API_Units"
    t.integer  "API_Array_Rows"
    t.integer  "API_Array_Columns"
    t.integer  "API_Spot_Rows"
    t.integer  "API_Spot_Columns"
    t.decimal  "API_Array_Row_Spacing",            :precision => 8, :scale => 2
    t.decimal  "API_Array_Column_Spacing",         :precision => 8, :scale => 2
    t.decimal  "API_Spot_Row_Spacing",             :precision => 8, :scale => 2
    t.decimal  "API_Spot_Column_Spacing",          :precision => 8, :scale => 2
    t.integer  "API_Spot_Diameter"
    t.integer  "API_Interstitial"
    t.integer  "API_Spots_Per_Array"
    t.integer  "API_Total_Spots"
    t.string   "NI_Normalization_Method"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "protocols_id"
    t.text     "consumables"
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
    t.decimal  "rank",       :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oligo_sequences", :force => true do |t|
    t.string   "dna_sequence",                        :null => false
    t.string   "name",                                :null => false
    t.string   "code"
    t.text     "description"
    t.integer  "partner_id",                          :null => false
    t.integer  "people_id",                           :null => false
    t.integer  "partner_people_id"
    t.integer  "taxonomy_id"
    t.string   "taxonomy_name"
    t.datetime "oligoDate"
    t.boolean  "available",         :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oligo_sequences", ["partner_id"], :name => "index_oligo_sequences_on_partner_id"
  add_index "oligo_sequences", ["people_id"], :name => "index_oligo_sequences_on_people_id"

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
    t.string   "lastname",   :null => false
    t.string   "phone"
    t.string   "email",      :null => false
    t.string   "town"
    t.binary   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "sampling_equipments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sampling_sites", :force => true do |t|
    t.string   "code",                                                                   :null => false
    t.string   "name"
    t.integer  "altitude_types_id",                                  :default => 1
    t.integer  "catchment_areas_id",                                 :default => 1
    t.integer  "size_typologies_id",                                 :default => 1
    t.integer  "geologies_id",                                       :default => 1
    t.integer  "depth_id",                                           :default => 1
    t.string   "link"
    t.integer  "water_types_id",                                                         :null => false
    t.integer  "water_uses_id",                                                          :null => false
    t.integer  "land_use_mappings_id",                                                   :null => false
    t.integer  "geos_id"
    t.string   "geos_type",                                          :default => "Site"
    t.text     "note"
    t.decimal  "distance_to_source",   :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sampling_sites", ["geos_id"], :name => "iss_gi"
  add_index "sampling_sites", ["land_use_mappings_id"], :name => "iss_lumi"
  add_index "sampling_sites", ["water_types_id"], :name => "iss_wti"
  add_index "sampling_sites", ["water_uses_id"], :name => "iss_wui"

  create_table "samplings", :force => true do |t|
    t.string   "code"
    t.decimal  "volume",                 :precision => 4, :scale => 2,                  :null => false
    t.integer  "sampling_site_id",                                                      :null => false
    t.integer  "partner_id",                                                            :null => false
    t.datetime "samplingDate",                                                          :null => false
    t.text     "note"
    t.decimal  "air_temperature",        :precision => 4, :scale => 2, :default => 0.0
    t.decimal  "moisture",               :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "pressure",               :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "windSpeed",              :precision => 8, :scale => 2, :default => 0.0
    t.string   "windDirection",                                        :default => ""
    t.decimal  "waterFlow",              :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "lightIntensity",         :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "rainfallEvents",         :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "depth",                  :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "turbidity",              :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "salinity",               :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "tidalRange",             :precision => 4, :scale => 2, :default => 0.0
    t.string   "operators"
    t.decimal  "water_temperature",      :precision => 4, :scale => 2, :default => 0.0
    t.decimal  "conductivity",           :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "phosphates",             :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "nitrates",               :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "ph",                     :precision => 4, :scale => 2, :default => 0.0
    t.decimal  "nitrogen",               :precision => 4, :scale => 2, :default => 0.0
    t.decimal  "bod5",                   :precision => 4, :scale => 2, :default => 0.0
    t.decimal  "cod",                    :precision => 5, :scale => 3, :default => 0.0
    t.decimal  "h2osat",                 :precision => 5, :scale => 3, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sampling_equipments_id"
    t.text     "storage"
  end

  add_index "samplings", ["partner_id"], :name => "index_samplings_on_partner_id"
  add_index "samplings", ["sampling_site_id"], :name => "index_samplings_on_sampling_site_id"

  create_table "size_typologies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

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

  create_table "water_types", :force => true do |t|
    t.string   "code",        :null => false
    t.string   "name",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "water_uses", :force => true do |t|
    t.string   "code",        :null => false
    t.string   "name",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "wfilters", :force => true do |t|
    t.string   "name",                                                   :default => ""
    t.decimal  "pore_size",                :precision => 5, :scale => 3, :default => 0.0
    t.integer  "num_filters", :limit => 2,                               :default => 0
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wfilters", ["pore_size", "num_filters"], :name => "wf_u", :unique => true

end
