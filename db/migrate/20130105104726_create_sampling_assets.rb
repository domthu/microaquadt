class CreateSamplingAssets < ActiveRecord::Migration
  def self.up
    create_table :sampling_assets do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :sampling_assets
  end
end
