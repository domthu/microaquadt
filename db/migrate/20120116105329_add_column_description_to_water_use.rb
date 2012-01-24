class AddColumnDescriptionToWaterUse < ActiveRecord::Migration
  def self.up

    add_column :water_uses, :description, :text
    add_column :water_types, :description, :text
    add_column :altitude_types, :description, :text
    add_column :size_typologies, :description, :text
    add_column :depths, :description, :text
    add_column :geologies, :description, :text
    add_column :catchment_areas, :description, :text

    #Add reference to :sampling_equipments for Sampling
    change_table :samplings do |t|
        t.references :sampling_equipments, :null => true
    end
    #add_references :oligo_sequences, :sampling_equipments
    #add_column :oligo_sequences, :sampling_equipment_id
    add_column :samplings, :storage, :text, :null => true



    #Add reference to Protocol for WaterSample
#Missing information on sample preparation (DNA/RNA extraction), PCR, etc.
#+ table filter_sample_preparation 1ton to filter_sample "DNA extraction" "RNA extraction" "PCR" default empty. Name & Note
    add_column :filter_samples, :storage, :text, :null => true

    change_table :micro_arrays do |t|
        t.references :protocols, :null => true
    end

  end

  def self.down
    remove_column :water_uses, :description
    remove_column :water_types, :description
    remove_column :altitude_types, :description
    remove_column :size_typologies, :description
    remove_column :depths, :description
    remove_column :geologies, :description
    remove_column :catchment_areas, :description

    #remove_column :samplings, :sampling_equipments_id
    remove_references :samplings, :sampling_equipments
    remove_column :samplings, :storage

    #remove_column :micro_arrays, :protocols_id
    remove_references :micro_arrays, :protocols

    remove_column :filter_samples, :storage

  end
end
