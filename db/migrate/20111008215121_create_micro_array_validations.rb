class CreateMicroArrayValidations < ActiveRecord::Migration
  def self.up
    create_table :micro_array_validations do |t|
      t.references :microarray
      t.text :note
      t.decimal :CellCount
      t.decimal :QPCR_decimal
      t.decimal :QPCR_Culture
      t.decimal :Chemscan

      t.timestamps
    end

    add_index :micro_array_validations, :microarray_id
end

  def self.down
    remove_index :micro_array_validations, :microarray_id
    drop_table :micro_array_validations
  end
end

