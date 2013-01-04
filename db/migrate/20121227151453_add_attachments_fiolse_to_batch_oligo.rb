class AddAttachmentsFiolseToBatchOligo < ActiveRecord::Migration
  def self.up
    add_column :batch_oligos, :fiolse_file_name, :string
    add_column :batch_oligos, :fiolse_content_type, :string
    add_column :batch_oligos, :fiolse_file_size, :integer
    add_column :batch_oligos, :fiolse_updated_at, :datetime
  end

  def self.down
    remove_column :batch_oligos, :fiolse_file_name
    remove_column :batch_oligos, :fiolse_content_type
    remove_column :batch_oligos, :fiolse_file_size
    remove_column :batch_oligos, :fiolse_updated_at
  end
end
