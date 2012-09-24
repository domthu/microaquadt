class CreateExperiments < ActiveRecord::Migration
  def self.up
    create_table :experiments do |t|
      t.references :filter_sample
      t.references :microarraygal
      t.references :micro_array
      t.references :micro_array_validation
      t.references :micro_array_image
      t.references :micro_array_data
      t.references :micro_array_analysis_file
      t.references :partner
      t.string :ecode, :null => true
      t.string :barcode, :null => false
      t.date :experiment_date
      t.text :note
      t.timestamps
    end
         
   add_index :experiments, :microarraygal_id
      add_index :experiments, :filter_sample_id
      add_index :experiments, :partner_id
      add_index :experiments, :micro_array_id
      add_index :experiments, :micro_array_validation_id
      add_index :experiments, :micro_array_image_id
      add_index :experiments, :micro_array_data_id
      add_index :experiments, :micro_array_analysis_file_id


  end

  def self.down
    remove_index :experiments, :microarraygal_id
    remove_index :experiments, :filter_sample_id
    remove_index :experiments, :partner_id
    remove_index :experiments, :micro_array_id
    remove_index :experiments, :micro_array_validation_id
    remove_index :experiments, :micro_array_image_id 
    remove_index :experiments, :micro_array_data_id
    remove_index :experiments, :micro_array_analysis_file_id     
    drop_table :experiments
  end
end
