class CreateOligos < ActiveRecord::Migration
  def self.up
    create_table :oligos do |t|
      t.references :oligo_sequence
      t.string :code
      t.references :gal_header
      t.references :gal_block     
      t.string :row_number
      t.string :column_number
      t.references :microarraygal
      
      t.timestamps
    end
  add_index :oligos
  add_index :oligos, [:oligo_sequence_id, :microarraygal_id], :unique => true
  end

  def self.down
    remove_index :oligos
    remove_index :oligos, [:oligo_sequence_id, :microarraygal_id]
    drop_table :oligos
  end
end
