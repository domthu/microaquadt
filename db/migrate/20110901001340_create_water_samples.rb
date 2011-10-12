class CreateWaterSamples < ActiveRecord::Migration
  def self.up
    create_table :water_samples do |t|
      t.string :code, :null => false
      t.decimal :temperature
      t.decimal :turbidity
      t.decimal :conductivity
      t.decimal :phosphates
      t.decimal :nitrates
      t.decimal :volume
      t.decimal :ph
      #t.references :meteorological_datas
      #nome del modello al singolare_id
      #t.integer :sampling_id, :null => false
      t.references :sampling, :null => false
      t.datetime :samplingDate, :null => false
      #Non devo poter creare un water sample senza dover
      #creare un filter
      #t.references :wfilters, :null => true

      t.text :note

      t.timestamps
    end

    add_index :water_samples, :sampling_id
    #add_index :water_samples, :wfilter_id
  end

  def self.down
    remove_index :water_samples, :sampling_id
    drop_table :water_samples
  end
end

