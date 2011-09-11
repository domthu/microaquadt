class CreatePartners < ActiveRecord::Migration
  def self.up
    create_table :partners do |t|
      t.integer :fp7_Number, :null => false
      t.string :Name, :null => false
      t.string :State, :null => false
      t.text :Address
      t.string :Phone
      t.string :Email, :null => false
      t.string :Site
      t.binary :logo

      t.timestamps
    end
  end

  def self.down
    drop_table :partners
  end
end
