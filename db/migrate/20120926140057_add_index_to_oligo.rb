class AddIndexToOligo < ActiveRecord::Migration
  def self.up
    add_index :oligos, :oligo_sequence_id
    add_index :oligos, [:oligo_sequence_id, :microarraygal_id], :unique => true
  end

  def self.down
    remove_index :oligos, :oligo_sequence_id
    remove_index :oligos, [:oligo_sequence_id, :microarraygal_id]
  end
end
