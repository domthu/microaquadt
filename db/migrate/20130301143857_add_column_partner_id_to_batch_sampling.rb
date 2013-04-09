class AddColumnPartnerIdToBatchSampling < ActiveRecord::Migration
  def self.up
    add_column :batch_samplings, :partner_id, :integer
  end

  def self.down
    remove_column :batch_samplings, :partner_id
  end
end
