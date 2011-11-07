class CreateSamplings < ActiveRecord::Migration
  def self.up
    create_table :samplings do |t|
      t.string :code, :null => true
      t.decimal :volume, :null => false, :precision => 4, :scale => 2
      t.references :sampling_site, :null => false
      t.references :partner, :null => false
      t.datetime :samplingDate, :null => false
      t.text :note

      t.decimal :temperature, :default => 0, :precision => 4, :scale => 2
      t.decimal :moisture, :default => 0, :precision => 8, :scale => 2
      t.decimal :pressure, :default => 0, :precision => 8, :scale => 2
      t.decimal :windSpeed, :default => 0, :precision => 8, :scale => 2
      t.string :windDirection, :default => ""
      t.decimal :waterFlow, :default => 0, :precision => 8, :scale => 2
      t.decimal :lightIntensity, :default => 0, :precision => 8, :scale => 2
      t.decimal :rainfallEvents, :default => 0, :precision => 8, :scale => 2
      t.decimal :depth, :default => 0, :precision => 8, :scale => 2
      t.decimal :turbidity, :default => 0, :precision => 8, :scale => 2
      t.decimal :salinity, :default => 0, :precision => 8, :scale => 2
      t.decimal :tidalRange, :default => 0, :precision => 4, :scale => 2

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

