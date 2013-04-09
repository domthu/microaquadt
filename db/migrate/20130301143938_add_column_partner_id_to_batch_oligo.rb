class AddColumnPartnerIdToBatchOligo < ActiveRecord::Migration
  def self.up
    add_column :batch_oligos, :partner_id, :integer
  end

  def self.down
    remove_column :batch_oligos, :partner_id
  end
end
