class CreateWaterUses < ActiveRecord::Migration
  def self.up
    create_table :water_uses do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :water_uses
  end
end
