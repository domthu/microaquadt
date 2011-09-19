class CreateSamplingSites < ActiveRecord::Migration
  def self.up
    create_table :sampling_sites do |t|
      t.string :code, :null => false
      t.string :name
      t.string :country
      t.string :aptitudeTypology
      t.string :catchmentArea
      t.string :geology
      t.string :depth
      t.string :sizeTypology
      t.decimal :salinity
      t.decimal :tidalRange
      t.references :water_types, :null => false
      t.references :water_uses, :null => false
      #t.integer :water_uses_id
      t.references :land_use_mappings, :null => false
      t.references :geos, :polymorphic => {:default => 'Site'}
      t.text :note

      t.timestamps
    end

    add_index :sampling_sites, :water_types_id
    add_index :sampling_sites, :water_uses_id
    add_index :sampling_sites, :land_use_mappings_id
    add_index :sampling_sites, :geos_id

  end

  def self.down
    drop_table :sampling_sites
  end
end

