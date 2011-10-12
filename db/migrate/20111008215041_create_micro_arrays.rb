class CreateMicroArrays < ActiveRecord::Migration
  def self.up
    create_table :micro_arrays do |t|
      t.string :gpr_title
      t.string :gpr_file_title
      t.binary :gpr_file
      t.text :note
      t.date :loaded_at
      t.references :partner
      t.string :H_name
      t.decimal :H_ScanArrayCSVFileFormat
      t.decimal :H_ScanArray_Express
      t.integer :H_Number_of_Columns
      t.datetime :I_DateTime
      t.string :I_GalFile
      t.string :I_Scanner
      t.string :I_User_Name
      t.string :I_Computer_Name
      t.string :I_Protocol
      t.string :I_Quantitation_Method
      t.string :I_Quality_Confidence_Calculation
      t.text :I_User_comments
      t.string :I_Image_Origin
      t.decimal :I_Temperature
      t.string :I_Laser_Powers
      t.decimal :I_Laser_On_Time
      t.string :I_PMT_Voltages
      t.integer :QP_Min_Percentile
      t.integer :QP_Max_Percentile
      t.integer :QM_Max_Footprint
      t.string :API_Units
      t.integer :API_Array_Rows
      t.integer :API_Array_Columns
      t.integer :API_Spot_Rows
      t.integer :API_Spot_Columns
      t.decimal :API_Array_Row_Spacing
      t.decimal :API_Array_Column_Spacing
      t.decimal :API_Spot_Row_Spacing
      t.decimal :API_Spot_Column_Spacing
      t.integer :API_Spot_Diameter
      t.integer :API_Interstitial
      t.integer :API_Spots_Per_Array
      t.integer :API_Total_Spots
      t.string :NI_Normalization_Method

      t.timestamps
    end
    add_index :micro_arrays, :partner_id

end

  def self.down
    remove_index :micro_arrays, :partner_id
    drop_table :micro_arrays
  end
end

