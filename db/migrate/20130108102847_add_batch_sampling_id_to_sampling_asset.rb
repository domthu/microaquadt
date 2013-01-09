class AddBatchSamplingIdToSamplingAsset < ActiveRecord::Migration
  def self.up
    add_column :sampling_assets, :batch_sampling_id, :integer
  end

  def self.down
    remove_column :sampling_assets, :batch_sampling_id
  end
end
