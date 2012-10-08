class AddIndexToGalHeader < ActiveRecord::Migration
  def self.up
    add_index :gal_headers, :microarraygal_id
  end

  def self.down
    remove_index :gal_headers, :microarraygal_id
  end
end
