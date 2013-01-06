class CreateBatchSamplings < ActiveRecord::Migration
  def self.up
    create_table :batch_samplings do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :batch_samplings
  end
end
