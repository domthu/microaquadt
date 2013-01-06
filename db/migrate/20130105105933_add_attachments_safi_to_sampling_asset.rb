class AddAttachmentsSafiToSamplingAsset < ActiveRecord::Migration
  def self.up
    add_column :sampling_assets, :safi_file_name, :string
    add_column :sampling_assets, :safi_content_type, :string
    add_column :sampling_assets, :safi_file_size, :integer
    add_column :sampling_assets, :safi_updated_at, :datetime
  end

  def self.down
    remove_column :sampling_assets, :safi_file_name
    remove_column :sampling_assets, :safi_content_type
    remove_column :sampling_assets, :safi_file_size
    remove_column :sampling_assets, :safi_updated_at
  end
end
