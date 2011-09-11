class CreateMeteorologicalDatas < ActiveRecord::Migration
  def self.up
    create_table :meteorological_datas do |t|
      t.decimal :Temperature
      t.decimal :Moisture
      t.decimal :Pressure
      t.decimal :WindSpeed
      t.string :WindDirection
      t.decimal :WaterFlow
      t.decimal :LightIntensity
      t.decimal :RainfallEvents

      t.timestamps
    end
  end

  def self.down
    drop_table :meteorological_datas
  end
end
