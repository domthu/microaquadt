class AddColumnPartnerIdToMicroArrayImage < ActiveRecord::Migration
  def self.up
    add_column :micro_array_images, :partner_id, :integer
  end

  def self.down
    remove_column :micro_array_images, :partner_id
  end
end
