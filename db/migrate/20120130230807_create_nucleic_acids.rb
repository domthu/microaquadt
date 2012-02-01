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

    add_index :nucleic_acids, :partner_id
    add_index :nucleic_acids, :nucleic_acid_type_id
    add_index :nucleic_acids, :filter_sample_id

    NucleicAcidType.create!(:name => "DNA", :description => "deoxyribonucleic acid")
    NucleicAcidType.create!(:name => "RNA", :description => "ribonucleic acid")

  end

  def self.down

    remove_index :nucleic_acids, :partner_id
    remove_index :nucleic_acids, :nucleic_acid_type_id
    remove_index :nucleic_acids, :filter_sample_id

    drop_table :nucleic_acids
  end
end
