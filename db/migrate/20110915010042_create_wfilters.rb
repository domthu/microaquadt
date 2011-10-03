class CreateWfilters < ActiveRecord::Migration
  def self.up
    create_table :wfilters do |t|
      t.string :name
      t.text :note

      #t.references posso creare un filter
      t.integer :water_samples_id, :null => false

      t.timestamps
    end

    add_index :wfilters, :water_samples_id

  end

  def self.down
    drop_table :wfilters
  end
end

