class AddIndexToMicroarraygal < ActiveRecord::Migration
  def self.up
    add_index :microarraygals, :partner_id
  end

  def self.down
    remove_index :microarraygals, :partner_id
  end
end
