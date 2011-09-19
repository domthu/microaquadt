class AddRememberTokenToUsers < ActiveRecord::Migration
  def self.up
    add_index :users, :name, :unique => true
    add_column :users, :remember_token, :string
    add_index  :users, :remember_token
  end

  def self.down
    remove_column :users, :remember_token
    remove_index :users, :name
    remove_index :users, :remember_token
  end
end

