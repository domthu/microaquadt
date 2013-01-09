class CreateBatchImages < ActiveRecord::Migration
  def self.up
    create_table :batch_images do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :batch_images
  end
end
