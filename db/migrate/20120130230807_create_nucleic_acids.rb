class CreateNucleicAcids < ActiveRecord::Migration
  def self.up
    create_table :nucleic_acids do |t|
      t.references :filter_sample
      t.references :nucleic_acid_type
      t.date :date
      t.references :partner
      t.string :code
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :nucleic_acids
  end
end
