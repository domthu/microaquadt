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
      t.references :sampling_site, :null => false
      t.references :partner, :null => false
      t.references :wfilter, :null => true
      t.datetime :samplingDate, :null => false
      t.text :note

      t.timestamps
    end

    add_index :samplings, :partner_id
    add_index :samplings, :sampling_site_id
    add_index :samplings, :filter_id
end

  def self.down
    drop_table :samplings
  end
end

