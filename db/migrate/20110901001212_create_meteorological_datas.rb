class CreateMeteorologicalDatas < ActiveRecord::Migration
  def self.up
    create_table :meteorological_datas do |t|
	  t.name :string, :null => false
      t.decimal :Temperature, :precision => 4, :scale => 2
      t.decimal :Moisture, :precision => 8, :scale => 2
      t.decimal :Pressure, :precision => 8, :scale => 2
      t.decimal :WindSpeed, :precision => 8, :scale => 2
      t.string :WindDirection
      t.decimal :WaterFlow, :precision => 8, :scale => 2
      t.decimal :LightIntensity, :precision => 8, :scale => 2
      t.decimal :RainfallEvents, :precision => 8, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :meteorological_datas
  end
end
