class CreateWfilters < ActiveRecord::Migration
  def self.up
    create_table :wfilters do |t|
      t.string :name
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :wfilters
  end
end
