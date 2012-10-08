class AddIndexToExperiment < ActiveRecord::Migration
  def self.up
    add_index :experiments, :microarraygal_id
    add_index :experiments, :filter_sample_id
    add_index :experiments, :partner_id
  end

  def self.down
    remove_index :experiments, :partner_id
    remove_index :experiments, :filter_sample_id
    remove_index :experiments, :microarraygal_id
  end
end
