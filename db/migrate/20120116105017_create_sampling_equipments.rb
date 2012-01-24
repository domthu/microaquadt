class CreateSamplingEquipments < ActiveRecord::Migration
  def self.up
    create_table :sampling_equipments do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :sampling_equipments
  end
end
