class CreateWaterSamples < ActiveRecord::Migration
  def self.up
    create_table :water_samples do |t|
      t.decimal :Temperature
      t.decimal :Turbidity
      t.decimal :Conductivity
      t.decimal :Ph
      t.references :water_sample
      t.string :Code
      t.references :meteorological_data
      t.references :water_type
      t.references :water_use
      t.references :sampling_site
      t.references :partner
      t.references :geo

      t.timestamps
    end
  end

  def self.down
    drop_table :water_samples
  end
end
