class CreateMicroarrayOligos < ActiveRecord::Migration
  def self.up
    create_table :microarray_oligos do |t|
    t.references :microarraygal
    t.references :oligo_sequence
    t.date :tested_at
    t.timestamps
    end
    add_index :microarray_oligos, :microarraygal_id
    add_index :microarray_oligos, :oligo_sequence_id
  end

  def self.down
    remove_index :microarray_oligos, :microarraygal_id
    remove_index :microarray_oligos, :oligo_sequence_id
    drop_table :microarray_oligos
  end
end
