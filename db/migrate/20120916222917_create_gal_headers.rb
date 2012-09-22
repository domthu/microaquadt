class CreateGalHeaders < ActiveRecord::Migration
  def self.up
    create_table :gal_headers do |t|
      t.string :gal_version_info
      t.string :number_data_column
      t.string :gal_row_count
      t.string :gal_column_count
      t.string :block_type
      t.string :block_count
      t.string :supplier
      t.references :microarraygal	
      t.timestamps
    end
    add_index :gal_headers, :microarraygal_id 
  end

  def self.down
    remove_index :gal_headers, :microarraygal_id
    drop_table :gal_headers
  end
end
