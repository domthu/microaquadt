class CreateMicroArrayAnalysisFiles < ActiveRecord::Migration
  def self.up
    create_table :micro_array_analysis_files do |t|
      t.references :microarray
      t.text :note
      t.string :MIANE_Standard

      t.timestamps
    end

    add_index :micro_array_analysis_files, :microarray_id
end

  def self.down
    remove_index :micro_array_analysis_files, :microarray_id
    drop_table :micro_array_analysis_files
  end
end

