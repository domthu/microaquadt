class CreateProtocols < ActiveRecord::Migration
  def self.up
    create_table :protocols do |t|
	    t.string :name, :null => false
      t.text :GrowthProtocol
      t.text :TreatmentProtocol
      t.text :ExtractProtocol
      t.text :LabelProtocol
      t.text :HybProtocol
      t.text :ScanProtocol
      t.text :DataProcessing
      t.text :ValueDefinition

      #t.references posso creare un protocol
      t.integer :water_sample_id, :null => false

      t.timestamps
    end

    add_index :protocols, :water_sample_id

  end

  def self.down
    drop_table :protocols
  end
end

