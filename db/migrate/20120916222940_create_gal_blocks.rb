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
   add_index :gal_blocks, :microarraygal_id 
  end

  def self.down
    remove_index :gal_blocks, :microarraygal_id
    drop_table :gal_blocks
  end
end
