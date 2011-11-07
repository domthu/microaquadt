class CreateDepths < ActiveRecord::Migration
  def self.up
    create_table :depths do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :depths
  end
end
