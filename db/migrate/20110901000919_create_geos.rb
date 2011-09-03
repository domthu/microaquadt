class CreateGeos < ActiveRecord::Migration
  def self.up
    create_table :geos do |t|
      t.string :name
      t.decimal :lon
      t.decimal :lat

      t.timestamps
    end
  end

  def self.down
    drop_table :geos
  end
end
