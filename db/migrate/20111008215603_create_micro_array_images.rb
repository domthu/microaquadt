class CreateMicroArrayImages < ActiveRecord::Migration
  def self.up
    create_table :micro_array_images do |t|
      t.references :microarray
      t.text :note
      t.string :name
      t.binary :image
      t.integer :II_ImageID
      t.string :II_Channel
      t.string :II_Image
      t.string :II_Fluorophore
      t.string :II_Barcode
      t.string :II_Units
      t.decimal :II_X_Units_Per_Pixel
      t.decimal :II_Y_Units_Per_Pixel
      t.decimal :II_X_Offset
      t.decimal :II_Y_Offset
      t.string :II_Status

      t.timestamps
    end

    add_index :micro_array_images, :microarray_id
end

  def self.down
    remove_index :micro_array_images, :microarray_id
    drop_table :micro_array_images
  end
end

