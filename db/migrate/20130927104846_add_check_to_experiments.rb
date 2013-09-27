class AddCheckToExperiments < ActiveRecord::Migration
  def self.up
    add_column :experiments, :check, :boolean, :default => false
  end

  def self.down
    remove_column :experiments, :check
  end
end
