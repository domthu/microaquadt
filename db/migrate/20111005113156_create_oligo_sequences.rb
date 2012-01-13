class CreateOligoSequences < ActiveRecord::Migration
  def self.up
    create_table :oligo_sequences do |t|
      t.string :dna_sequence, :null => false, :lenght => 100
      t.string :name, :null => false
      t.string :code, :null => true
#      t.text :note
      t.text :description

      t.references :partner, :null => false
      t.references :people, :null => false
      t.references :partner_people, :null => true

#     t.references :tax_id
#     t.remove :tax_id_id
#     t.rename :tax_id_id, :taxonomy_id 
#     remove_column :oligo_sequences, :tax_id_id

      t.integer :taxonomy_id, :null => true
      t.string :taxonomy_name
      t.datetime :oligoDate, :null => true
      t.boolean :available, :default => 1

      t.timestamps
    end
#Oligo 
# - id
# - sequenza (30 average)
#sequenze di TTTTT solo per separator vetri
# - Partner_id
# - Person_id Foreign Key not ManyToMany
# - Data
# - partner_barcode Sigla Partner identificator stringha "GENxx"   per ricerche personale
# - Taxonomy ID  --> Convention NCBI - bacterio, orgismo,  ...
# - available (SI NO) se dispone ancora del materiale oligo (inviare ad altri) 
# - note per informazione su keyword 

    add_index :oligo_sequences, :partner_id
    add_index :oligo_sequences, :people_id

  end

  def self.down
    remove_index :oligo_sequences, :partner_id
    remove_index :oligo_sequences, :people_id
    drop_table :oligo_sequences
  end
end

