class AddMicroarraygprIdToExperiment < ActiveRecord::Migration
  def self.up
    add_column :experiments, :microarraygpr_id, :integer
  end

  def self.down
    remove_column :experiments, :microarraygpr_id
  end
end
