class CreateOligoSequences < ActiveRecord::Migration
  def self.up
    create_table :oligo_sequences do |t|
      t.string :name
      t.text :description
      t.references :partner
      t.string :DNA_Sequence
      t.references :tax_id
      t.references :partner, :null => false

      t.timestamps
    end
    add_index :oligo_sequences, :partner_id
  end

  def self.down
    remove_index :oligo_sequences, :partner_id
    drop_table :oligo_sequences
  end
end

