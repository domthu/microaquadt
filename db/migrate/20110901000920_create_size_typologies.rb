class CreateSizeTypologies < ActiveRecord::Migration
  def self.up
    create_table :size_typologies do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :size_typologies
  end
end
