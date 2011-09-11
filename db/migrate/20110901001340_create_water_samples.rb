class CreateWaterSamples < ActiveRecord::Migration
  def self.up
    create_table :water_samples do |t|
      t.decimal :Temperature
      t.decimal :Turbidity
      t.decimal :Conductivity
      t.decimal :Ph
      t.string :Code
      t.references :meteorological_datas
      t.references :water_types
      t.references :water_uses
      t.references :partners
      t.references :land_use_mappings 
	  t.references :sampling_sites 
	  t.references :geos, :polymorphic => {:default => 'Water'} 

      t.timestamps
    end
  end

  def self.down
    drop_table :water_samples
  end
end
