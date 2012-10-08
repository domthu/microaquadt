class CreateGalBlocks < ActiveRecord::Migration
  def self.up
    create_table :gal_blocks do |t|
      t.string :block_number
      t.string :xOrigin
      t.string :yOrigin
      t.string :feature_diameter
      t.string :xFeatures
      t.string :xSpacing
      t.string :yFeatures
      t.string :ySpacing
      t.references :gal_header
      t.references :microarraygal

      t.timestamps
    end
  end

  def self.down
    drop_table :gal_blocks
  end
end
