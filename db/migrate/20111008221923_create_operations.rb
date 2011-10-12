class CreateOperations < ActiveRecord::Migration
  def self.up
    create_table :operations do |t|
      t.references :protocol
      t.string :name
      t.integer :step
      t.text :note

      t.timestamps
    end

    add_index :operations, :protocol_id
end

  def self.down
    remove_index :operations, :protocol_id
    drop_table :operations
  end
end

