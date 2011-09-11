class CreateLandUseMappings < ActiveRecord::Migration
  def self.up
    create_table :land_use_mappings do |t|
      t.string :name, :null => false
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :land_use_mappings
  end
end
