class CreateMicroarraygals < ActiveRecord::Migration
  def self.up
    create_table :microarraygals do |t|
      t.string :gal_title
      t.string :gal_file_title
      t.binary :gal_file
      t.string :code
      t.date :loaded_at
      t.string :barcode, :null => false
      t.references :partner, :null => false
      t.references :experiment
      t.references :oligo_sequence
      t.text :note
      t.timestamps
    end
     add_index :microarraygals, :oligo_sequence_id 
     add_index :experiments, :filter_sample_id
     add_index :microarraygals, :partner_id
     add_index :microarraygals, :experiment_id
     add_index :microarraygals, :oligo_sequence_id
  end

  def self.down
    remove_index :microarraygals, :oligo_sequence_id
    remove_index :experiments, :filter_sample_id
    remove_index :microarraygals, :partner_id 
    remove_index :microarraygals, :experiment_id
    remove_index :microarraygals, :oligo_sequence_id
    drop_table :microarraygals
  end
end
