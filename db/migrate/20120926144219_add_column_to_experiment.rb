class AddColumnToExperiment < ActiveRecord::Migration
  def self.up
    add_column :experiments, :people_id, :string
  end

  def self.down
    remove_column :experiments, :people_id
  end
end
