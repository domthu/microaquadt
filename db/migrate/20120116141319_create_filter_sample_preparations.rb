class CreateFilterSamplePreparations < ActiveRecord::Migration
  def self.up
    create_table :filter_sample_preparations do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :filter_sample_preparations
  end
end
