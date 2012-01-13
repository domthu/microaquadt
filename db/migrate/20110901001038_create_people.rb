class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :firstname, :null => false
      t.string :lastname, :null => false
      t.string :phone
      t.string :email, :null => false
      t.string :town
      t.binary :avatar

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end

