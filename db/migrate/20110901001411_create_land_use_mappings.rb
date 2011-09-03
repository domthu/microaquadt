class CreateLandUseMappings < ActiveRecord::Migration
  def self.up
    create_table :land_use_mappings do |t|
      t.string :note
      t.references :water_sample

      t.timestamps
    end
  end

  def self.down
    drop_table :land_use_mappings
  end
end
