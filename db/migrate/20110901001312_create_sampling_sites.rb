class CreateSamplingSites < ActiveRecord::Migration
  def self.up
    create_table :sampling_sites do |t|
      t.string :code, :null => false
      t.string :name
      t.references :altitude_types, :default => 1 
      t.references :catchment_areas, :default => 1
      t.references :size_typologies, :default => 1
      t.references :geologies, :default => 1
      t.references :depth, :default => 1
      t.string :link
      t.references :water_types, :null => false
      t.references :water_uses, :null => false
      #t.integer :water_uses_id
      t.references :land_use_mappings, :null => false
      #t.references :country, :null => false
      t.references :geos, :polymorphic => {:default => 'Site'}
      t.text :note

      t.decimal :distance_to_source, :default => 0, :precision => 8, :scale => 2

      t.timestamps
    end

    add_index :sampling_sites, :water_type_id, :name => 'iss_wti'
    add_index :sampling_sites, :water_use_id, :name => 'iss_wui'
    add_index :sampling_sites, :land_use_mapping_id, :name => 'iss_lumi'
    add_index :sampling_sites, :geo_id, :name => 'iss_gi'
    #add_index :sampling_sites, :country_id, :name => 'iss_ci'

  end

  def self.down
    remove_index :sampling_sites, :water_type_id
    remove_index :sampling_sites, :water_use_id
    remove_index :sampling_sites, :land_use_mapping_id
    remove_index :sampling_sites, :geo_id
    #remove_index :sampling_sites, :country_id

    drop_table :sampling_sites
  end
end

