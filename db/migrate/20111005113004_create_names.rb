class CreateNames < ActiveRecord::Migration
  def self.up
    create_table :names do |t|
      t.integer :tax_id
      t.string :name_txt
      t.string :unique_name
      t.string :name_class

      t.timestamps
    end
    add_index :names, :tax_id
    add_index :names, :name_txt
  end

  def self.down
    remove_index :names, :tax_id
    remove_index :names, :name_txt
    drop_table :names
  end
end

