class AddMicroArrayImageIdToImageAsset < ActiveRecord::Migration
  def self.up
    add_column :image_assets, :micro_array_image_id, :integer
  end

  def self.down
    remove_column :image_assets, :micro_array_image_id
  end
end
