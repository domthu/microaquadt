class AddReferenceToFilterSample < ActiveRecord::Migration
  def self.up

    change_table :filter_samples do |t|
        t.references :filter_sample_preparations, :null => true
    end

    add_column :micro_array_analysis_files, :protocol, :text, :null => true
    add_column :micro_array_analysis_files, :consumables, :text, :null => true

    add_column :micro_arrays, :consumables, :text, :null => true

  end

  def self.down
    #remove_column :filter_samples, :filter_sample_preparations_id
    remove_references :filter_samples, :filter_sample_preparations

    remove_column :micro_array_analysis_files, :protocol
    remove_column :micro_array_analysis_files, :consumables

    remove_column :micro_arrays, :consumables
  end
end
