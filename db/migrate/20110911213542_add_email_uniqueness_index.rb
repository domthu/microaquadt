class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :email, :unique => true
    add_index :partners, :email, :unique => true
    add_index :people, :email, :unique => true
  end

  def self.down
    remove_index :users, :email
    remove_index :partners, :email
    remove_index :people, :email
  end
end

