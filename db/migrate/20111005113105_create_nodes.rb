class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.reference :tax_id, :class_name => "Name"
      t.reference :parent_tax_id, :class_name => "Name"
      t.decimal :rank

      t.timestamps
    end
  end

  def self.down
    drop_table :nodes
  end
end

