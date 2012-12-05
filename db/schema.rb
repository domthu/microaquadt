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

ActiveRecord::Schema.define(:version => 20121129124328) do

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

  create_table "experiments", :force => true do |t|
    t.integer  "filter_sample_id"
    t.integer  "microarraygal_id"
    t.integer  "partner_id"
    t.string   "ecode"
    t.string   "barcode"
    t.date     "experiment_date"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "people_id"
    t.integer  "microarraygpr_id"
  end

  add_index "experiments", ["filter_sample_id"], :name => "index_experiments_on_filter_sample_id"
  add_index "experiments", ["microarraygal_id"], :name => "index_experiments_on_microarraygal_id"
  add_index "experiments", ["partner_id"], :name => "index_experiments_on_partner_id"

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

  create_table "gal_blocks", :force => true do |t|
    t.string   "block_number"
    t.string   "xOrigin"
    t.string   "yOrigin"
    t.string   "feature_diameter"
    t.string   "xFeatures"
    t.string   "xSpacing"
    t.string   "yFeatures"
    t.string   "ySpacing"
    t.integer  "gal_header_id"
    t.integer  "microarraygal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gal_blocks", ["microarraygal_id"], :name => "index_gal_blocks_on_microarraygal_id"

  create_table "gal_headers", :force => true do |t|
    t.string   "gal_version_info"
    t.string   "number_data_column"
    t.string   "gal_row_count"
    t.string   "gal_column_count"
    t.string   "block_type"
    t.string   "block_count"
    t.string   "supplier"
    t.integer  "microarraygal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gal_headers", ["microarraygal_id"], :name => "index_gal_headers_on_microarraygal_id"

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

  create_table "gpr_datas", :force => true do |t|
    t.integer  "microarraygpr_id"
    t.integer  "gpr_header_id"
    t.integer  "gal_block_id"
    t.string   "oligo_row"
    t.string   "oligo_column"
    t.string   "oligo_id"
    t.string   "oligo_name"
    t.string   "x"
    t.string   "y"
    t.string   "dia"
    t.string   "f635_median"
    t.string   "f635_mean"
    t.string   "f635_sd"
    t.string   "f635_cv"
    t.string   "b635"
    t.string   "b635_Median"
    t.string   "b635_mean"
    t.string   "b635_sd"
    t.string   "b635_cv"
    t.string   "percent_b635_1_sd"
    t.string   "percent_b635_2_sd"
    t.string   "f635_perc_sat"
    t.string   "f532_median"
    t.string   "f532_mean"
    t.string   "f532_sd"
    t.string   "f532_cv"
    t.string   "b532"
    t.string   "b532_median"
    t.string   "b532_mean"
    t.string   "b532_sd"
    t.string   "b532_cv"
    t.string   "percent_b532_1_sd"
    t.string   "percent_b532_2_sd"
    t.string   "f532_perc_sat"
    t.string   "ratio_of_medians"
    t.string   "ratio_of_means"
    t.string   "median_of_ratios"
    t.string   "mean_of_ratios"
    t.string   "ratios_sd"
    t.string   "rgn_ratio"
    t.string   "rgn_r2"
    t.string   "f_pixels"
    t.string   "b_pixels"
    t.string   "circularity"
    t.string   "sum_of_medians"
    t.string   "sum_of_means"
    t.string   "log_ratio"
    t.string   "f635_median_minus_b635"
    t.string   "f532_median_minus_b635"
    t.string   "f635_mean_minus_b635"
    t.string   "f532_mean_minus_b635"
    t.string   "f635_total_intensity"
    t.string   "f532_total_intensity"
    t.string   "snr_635"
    t.string   "snr_532"
    t.string   "flags"
    t.string   "normalize"
    t.string   "autoflag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gpr_headers", :force => true do |t|
    t.string   "gprVersion"
    t.string   "number_data_column"
    t.string   "gprtype"
    t.string   "datetime"
    t.string   "settings"
    t.string   "galfile"
    t.string   "pixelsize"
    t.string   "wavelengths"
    t.string   "imagefiles"
    t.string   "normalizationmethod"
    t.string   "normalizationfactors"
    t.string   "jpegimage"
    t.string   "stddev"
    t.string   "ratioformulations"
    t.string   "featuretype"
    t.string   "barcode"
    t.string   "backgroundsubtraction"
    t.string   "imageorigin"
    t.string   "jpegorigin"
    t.string   "creator"
    t.string   "scanner"
    t.string   "focusposition"
    t.string   "temp"
    t.string   "linesavg"
    t.string   "comment"
    t.string   "pmtgain"
    t.string   "scanpower"
    t.string   "laserpower"
    t.string   "filters"
    t.string   "scanregion"
    t.string   "supplier"
    t.integer  "microarraygpr_id"
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
    t.integer  "experiment_id"
    t.text     "note"
    t.string   "MIANE_Standard"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "micro_array_images", :force => true do |t|
    t.integer  "experiment_id"
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

  create_table "micro_array_validations", :force => true do |t|
    t.integer  "experiment_id"
    t.text     "note"
    t.decimal  "CellCount",     :precision => 8, :scale => 2
    t.decimal  "QPCR_decimal",  :precision => 8, :scale => 2
    t.decimal  "QPCR_Culture",  :precision => 8, :scale => 2
    t.decimal  "Chemscan",      :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "microarraygals", :force => true do |t|
    t.string   "gal_title"
    t.string   "gal_file_title"
    t.binary   "gal_file"
    t.string   "code"
    t.date     "loaded_at"
    t.string   "barcode"
    t.integer  "partner_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microarraygals", ["partner_id"], :name => "index_microarraygals_on_partner_id"

  create_table "microarraygprs", :force => true do |t|
    t.string   "gpr_title"
    t.string   "gpr_file_title"
    t.binary   "gpr_file"
    t.string   "code"
    t.date     "loaded_at"
    t.string   "barcode"
    t.integer  "partner_id"
    t.text     "note"
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
    t.decimal  "rank",       :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nucleic_acid_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nucleic_acids", :force => true do |t|
    t.integer  "filter_sample_id"
    t.integer  "nucleic_acid_type_id"
    t.date     "date"
    t.integer  "partner_id"
    t.string   "code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nucleic_acids", ["filter_sample_id"], :name => "index_nucleic_acids_on_filter_sample_id"
  add_index "nucleic_acids", ["nucleic_acid_type_id"], :name => "index_nucleic_acids_on_nucleic_acid_type_id"
  add_index "nucleic_acids", ["partner_id"], :name => "index_nucleic_acids_on_partner_id"

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

  create_table "oligos", :force => true do |t|
    t.string   "code"
    t.string   "oligo_id"
    t.integer  "gal_header_id"
    t.integer  "gal_block_id"
    t.string   "row_number"
    t.string   "column_number"
    t.integer  "microarraygal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oligos", ["code", "microarraygal_id"], :name => "index_oligos_on_code_and_microarraygal_id"
  add_index "oligos", ["code"], :name => "index_oligos_on_code"

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

  add_index "partner_people", ["partner_id", "person_id"], :name => "index_partner_people_on_partner_id_and_person_id", :unique => true
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

  create_table "sampling_equipments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sampling_sites", :force => true do |t|
    t.string   "code",                                                                  :null => false
    t.string   "name"
    t.integer  "altitude_types_id",                                 :default => 1
    t.integer  "catchment_areas_id",                                :default => 1
    t.integer  "size_typologies_id",                                :default => 1
    t.integer  "geologies_id",                                      :default => 1
    t.integer  "depth_id",                                          :default => 1
    t.string   "link"
    t.integer  "water_type_id",                                                         :null => false
    t.integer  "water_use_id",                                                          :null => false
    t.integer  "land_use_mapping_id",                                                   :null => false
    t.integer  "geo_id"
    t.string   "geos_type",                                         :default => "Site"
    t.text     "note"
    t.decimal  "distance_to_source",  :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sampling_sites", ["geo_id"], :name => "index_sampling_sites_on_geo_id"
  add_index "sampling_sites", ["geo_id"], :name => "iss_gi"
  add_index "sampling_sites", ["land_use_mapping_id"], :name => "index_sampling_sites_on_land_use_mapping_id"
  add_index "sampling_sites", ["land_use_mapping_id"], :name => "iss_lumi"
  add_index "sampling_sites", ["water_type_id"], :name => "index_sampling_sites_on_water_type_id"
  add_index "sampling_sites", ["water_type_id"], :name => "iss_wti"
  add_index "sampling_sites", ["water_use_id"], :name => "index_sampling_sites_on_water_use_id"
  add_index "sampling_sites", ["water_use_id"], :name => "iss_wui"

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
