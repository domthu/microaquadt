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
      t.integer :samplings_id, :null => false
      t.datetime :samplingDate, :null => false
      #Non devo poter creare un water sample senza dover
      #creare un filter o protocols
      #t.references :wfilters, :null => true
      #t.references :protocols, :null => true

      t.text :note

      t.timestamps
    end

    add_index :water_samples, :samplings_id
    #add_index :water_samples, :wfilters_id
    #add_index :water_samples, :protocols_id
  end

  def self.down
    drop_table :water_samples
  end
end

