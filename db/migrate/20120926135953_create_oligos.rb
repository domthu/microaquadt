class CreateOligos < ActiveRecord::Migration
  def self.up
    create_table :oligos do |t|
      t.string :code
      t.references :oligo_sequence
      t.references :gal_header
      t.references :gal_block
      t.string :row_number
      t.string :column_number
      t.references :microarraygal

      t.timestamps
    end
  end

  def self.down
    drop_table :oligos
  end
end
