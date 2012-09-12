class AddSomeIndex < ActiveRecord::Migration
  def self.up
#      t.references :water_types, :null => false
#      t.references :water_uses, :null => false
#      t.references :land_use_mappings, :null => false
#      t.references :geos, :polymorphic => {:default => 'Site'}

#    add_index :sampling_sites, :water_types_id, :name => 'iss_wti'
#    add_index :sampling_sites, :water_uses_id, :name => 'iss_wui'
#    add_index :sampling_sites, :land_use_mappings_id, :name => 'iss_lumi'
#    add_index :sampling_sites, :geos_id, :name => 'iss_gi'
#--> KAPPAO  add_index :sampling_sites, :water_types_id,

   # remove_index :sampling_sites, :water_type_id
   # remove_index :sampling_sites, :water_use_id
   # remove_index :sampling_sites, :land_use_mapping_id
   # remove_index :sampling_sites, :geo_id

    #change_table :sampling_sites do |t|
     # t.rename :water_types_id, :water_type_id 
     # t.rename :water_uses_id, :water_use_id
      #t.rename :land_use_mappings_id, :land_use_mapping_id
      #t.rename :geos_id, :geo_id
    #end

    add_index :sampling_sites, :water_type_id
    add_index :sampling_sites, :water_use_id
    add_index :sampling_sites, :land_use_mapping_id
    add_index :sampling_sites, :geo_id

#20120201 --> TODO. After rake migrate this migration the code have to be changed tables_id --> table_id
#and set 
#{ :field => "w_use_name", :label => "Water use", :sortable => true, :resizable => false, :search => true},
#{ :field => "w_type_name", :label => "Water type", :sortable => true, :resizable => false, :search => true},
#{ :field => "land_name", :label => "Land", :sortable => true, :resizable => false, :search => true},
#{ :field => "geo_name", :label => "Geo pos.", :sortable => true, :resizable => false, :search => true},

  end

  def self.down
  end
end
