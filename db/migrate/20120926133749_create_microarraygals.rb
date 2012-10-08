class CreateMicroarraygals < ActiveRecord::Migration
  def self.up
    create_table :microarraygals do |t|
      t.string :gal_title
      t.string :gal_file_title
      t.binary :gal_file
      t.string :code
      t.date :loaded_at
      t.string :barcode
      t.references :partner
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :microarraygals
  end
end
