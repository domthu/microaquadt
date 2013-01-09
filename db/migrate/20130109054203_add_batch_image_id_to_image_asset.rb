class AddBatchImageIdToImageAsset < ActiveRecord::Migration
  def self.up
    add_column :image_assets, :batch_image_id, :integer
  end

  def self.down
    remove_column :image_assets, :batch_image_id
  end
end
