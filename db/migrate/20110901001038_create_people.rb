class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :firstname
      t.string :LastName
      t.string :Phone
      t.string :Email
      t.string :Town

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
