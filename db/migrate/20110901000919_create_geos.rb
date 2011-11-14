class CreateGeos < ActiveRecord::Migration
  def self.up
    create_table :geos do |t|
        t.string :name, :null => false
        t.decimal :lon, :null => false, :precision => 10, :scale => 8
        t.decimal :lat, :null => false, :precision => 10, :scale => 8
        t.references :country, :null => false

        t.decimal :width, :default => 0, :precision => 8, :scale => 2

        t.timestamps

    end

    add_index :geos, :country_id
  end



  def self.down
    remove_index :geos, :country_id

    drop_table :geos
  end
end

