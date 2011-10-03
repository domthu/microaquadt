class CreatePartners < ActiveRecord::Migration
  def self.up
    create_table :partners do |t|
      t.integer :fp7_Number, :null => false
      t.string :code, :null => false
      t.string :name, :null => false
      t.string :state, :null => false
      t.text :address
      t.string :phone
      t.string :email, :null => false
      t.string :site
      t.binary :logo
      t.integer :user_id

      t.timestamps
    end

    add_index :partners, :user_id
  end

  def self.down
    drop_table :partners
  end
end

