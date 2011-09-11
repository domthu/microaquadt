class CreateGeos < ActiveRecord::Migration
  def self.up
    create_table :geos do |t|
      t.string :name, :null => false
      t.decimal :lon, :null => false
      t.decimal :lat, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :geos
  end
end
