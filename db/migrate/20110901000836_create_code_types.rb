class CreateCodeTypes < ActiveRecord::Migration
  def self.up
    create_table :code_types do |t|
      t.string :code, :null => false
      t.string :name, :null => false
      t.references :partner, :null => false

      t.timestamps
    end
    add_index :code_types, :partner_id
  end

  def self.down
    remove_index :code_types, :partner_id
    drop_table :code_types
  end
end

