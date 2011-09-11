class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :email, :unique => true
    add_index :partners, :Email, :unique => true
    add_index :persons, :Email, :unique => true
  end

  def self.down
    remove_index :users, :email
    remove_index :partners, :Email
    remove_index :persons, :Email
  end
end

