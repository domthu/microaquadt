class CreateCatchmentAreas < ActiveRecord::Migration
  def self.up
    create_table :catchment_areas do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :catchment_areas
  end
end
