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
      t.references :sampling, :null => false
      #t.integer :sampling_id, :null => false

      t.timestamps
    end

    add_index :protocols, :sampling_id

  end

  def self.down
    remove_index :protocols, :sampling_id
    drop_table :protocols
  end
end

