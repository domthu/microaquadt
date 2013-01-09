class AddAttachmentsImageToImageAsset < ActiveRecord::Migration
  def self.up
    add_column :image_assets, :image_file_name, :string
    add_column :image_assets, :image_content_type, :string
    add_column :image_assets, :image_file_size, :integer
    add_column :image_assets, :image_updated_at, :datetime
  end

  def self.down
    remove_column :image_assets, :image_file_name
    remove_column :image_assets, :image_content_type
    remove_column :image_assets, :image_file_size
    remove_column :image_assets, :image_updated_at
  end
end
