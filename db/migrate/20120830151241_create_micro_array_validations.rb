class CreateMicroArrayValidations < ActiveRecord::Migration
  def self.up
    create_table :micro_array_validations do |t|
      t.references :experiment
      t.text :note
      t.decimal :CellCount, :precision => 8, :scale => 2
      t.decimal :QPCR_decimal, :precision => 8, :scale => 2
      t.decimal :QPCR_Culture, :precision => 8, :scale => 2
      t.decimal :Chemscan, :precision => 8, :scale => 2

      t.timestamps
    end

   add_index :micro_array_validations, :experiment_id
end

  def self.down
   remove_index :micro_array_validations, :experiment_id 
    drop_table :micro_array_validations
  end
end

