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
      t.text :alueDefinition

      t.timestamps
    end
  end

  def self.down
    drop_table :protocols
  end
end
