class CreateBatchOligos < ActiveRecord::Migration
  def self.up
    create_table :batch_oligos do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :batch_oligos
  end
end
