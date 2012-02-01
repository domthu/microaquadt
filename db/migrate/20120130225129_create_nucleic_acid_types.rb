class CreateNucleicAcidTypes < ActiveRecord::Migration
  def self.up
    create_table :nucleic_acid_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :nucleic_acid_types
  end
end
