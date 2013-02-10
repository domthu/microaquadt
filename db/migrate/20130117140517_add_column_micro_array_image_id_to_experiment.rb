class AddColumnMicroArrayImageIdToExperiment < ActiveRecord::Migration
  def self.up
    add_column :experiments, :micro_array_image_id, :integer
  end

  def self.down
    remove_column :experiments, :micro_array_image_id
  end
end
