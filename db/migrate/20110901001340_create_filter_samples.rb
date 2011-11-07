class CreateFilterSamples < ActiveRecord::Migration
  def self.up
    create_table :filter_samples do |t|
      #nome del modello al singolare_id
      #t.integer :sampling_id, :null => false
      t.references :sampling, :null => false
      t.datetime :samplingDate, :null => false

      t.references :wfilter, :null => false
      t.decimal :pore_size, :default => 0, :precision => 5, :scale => 3
      t.decimal :num_filters, :default => 0, :precision => 2, :scale => 0
      t.decimal :avg_qta, :default => 0, :precision => 4, :scale => 2
      t.decimal :volume, :null => false, :precision => 4, :scale => 2
      t.string :barcode, :null => false

      t.string :code, :null => true
      t.decimal :temperature, :default => 0, :precision => 4, :scale => 2
      t.decimal :turbidity, :default => 0, :precision => 8, :scale => 2
      t.decimal :conductivity, :default => 0, :precision => 8, :scale => 2
      t.decimal :phosphates, :default => 0, :precision => 8, :scale => 2
      t.decimal :nitrates, :default => 0, :precision => 8, :scale => 2
      t.decimal :ph, :default => 0, :precision => 4, :scale => 2

      t.text :note

      t.timestamps
    end

    add_index :filter_samples, :sampling_id
    add_index :filter_samples, :wfilter_id
  end

  def self.down
    remove_index :filter_samples, :sampling_id
    remove_index :filter_samples, :wfilter_id

    drop_table :filter_samples
  end
end

