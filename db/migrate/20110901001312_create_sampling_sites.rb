class CreateSamplingSites < ActiveRecord::Migration
  def self.up
    create_table :sampling_sites do |t|
      t.string :Code, :null => false
      t.references :water_types
      t.references :water_uses
      t.references :geos, :polymorphic => {:default => 'Site'} 

      t.timestamps
    end
  end

  def self.down
    drop_table :sampling_sites
  end
end


