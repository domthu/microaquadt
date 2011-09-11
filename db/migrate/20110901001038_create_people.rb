class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :firstname, :null => false
      t.string :LastName, :null => false
      t.string :Phone
      t.string :Email, :null => false
      t.string :Town
      t.binary :avatar

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
