class AddIndexToGalBlock < ActiveRecord::Migration
  def self.up
    add_index :gal_blocks, :microarraygal_id
  end

  def self.down
    remove_index :gal_blocks, :microarraygal_id
  end
end
