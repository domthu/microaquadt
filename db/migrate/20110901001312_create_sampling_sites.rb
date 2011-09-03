class CreateSamplingSites < ActiveRecord::Migration
  def self.up
    create_table :sampling_sites do |t|
      t.string :Code
      t.references :sampling_site
      t.references :water_type
      t.references :water_use
      t.references :geo

      t.timestamps
    end
  end

  def self.down
    drop_table :sampling_sites
  end
end
