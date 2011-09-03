class CreatePartners < ActiveRecord::Migration
  def self.up
    create_table :partners do |t|
      t.integer :fp7_Number
      t.string :Name
      t.string :State
      t.text :Address
      t.string :Phone
      t.string :Email
      t.string :Site

      t.timestamps
    end
  end

  def self.down
    drop_table :partners
  end
end
