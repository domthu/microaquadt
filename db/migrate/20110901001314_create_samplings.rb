class CreateSamplings < ActiveRecord::Migration
  def self.up
    create_table :samplings do |t|
      t.string :code, :null => false
      t.decimal :temperature
      t.decimal :moisture
      t.decimal :pressure
      t.decimal :windSpeed
      t.string :windDirection
      t.decimal :waterFlow
      t.decimal :lightIntensity
      t.decimal :rainfallEvents
      t.decimal :depth
      t.decimal :turbidity
      t.references :sampling_site, :null => false
      t.references :partner, :null => false
      t.datetime :samplingDate, :null => false
      t.text :note

      t.timestamps
    end

    add_index :samplings, :partner_id
    add_index :samplings, :sampling_site_id
end

  def self.down
    remove_index :samplings, :partner_id
    remove_index :samplings, :sampling_site_id
    drop_table :samplings
  end
end

