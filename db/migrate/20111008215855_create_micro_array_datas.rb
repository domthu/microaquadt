class CreateMicroArrayDatas < ActiveRecord::Migration
  def self.up
    create_table :micro_array_datas do |t|
      t.references :microarray
      t.text :note
      t.decimal :D_Index
      t.decimal :D_Array_Row
      t.decimal :D_Array_Column
      t.decimal :D_Spot_Row
      t.decimal :D_Spot_Column
      t.decimal :D_Name
      t.decimal :D_ID
      t.decimal :D_X
      t.decimal :D_Y
      t.decimal :D_Diameter
      t.decimal :D_F_Pixels
      t.decimal :D_B_Pixels
      t.decimal :D_Footprint
      t.decimal :D_Flags
      t.decimal :D_Ch1_Median
      t.decimal :D_Ch1_Mean
      t.decimal :D_Ch1_SD
      t.decimal :D_Ch1_B_Median
      t.decimal :D_Ch1_B_Mean
      t.decimal :D_Ch1_B_SD
      t.decimal :D_Ch1_B_1_SD
      t.decimal :D_Ch1_B_2_SD
      t.decimal :D_Ch1_F_Sat
      t.decimal :D_Ch1_Median_B
      t.decimal :D_Ch1_Mean_B
      t.decimal :D_Ch1_SignalNoiseRatio
      t.decimal :D_Ch2_Median
      t.decimal :D_Ch2_Mean
      t.decimal :D_Ch2_SD
      t.decimal :D_Ch2_B_Median
      t.decimal :D_Ch2_B_Mean
      t.decimal :D_Ch2_B_SD
      t.decimal :D_Ch2_B_1_SD
      t.decimal :D_Ch2_B_2_SD
      t.decimal :D_Ch2_F_Sat
      t.decimal :D_Ch2_Median_B
      t.decimal :D_Ch2_Mean_B
      t.decimal :D_Ch2_SignalNoiseRatio
      t.decimal :D_Ch2_Ratio_of_Medians
      t.decimal :D_Ch2_Ratio_of_Means
      t.decimal :D_Ch2_Median_of_Ratios
      t.decimal :D_Ch2_Mean_of_Ratios
      t.decimal :D_Ch2_Ratios_SD
      t.decimal :D_Ch2_Rgn_Ratio
      t.decimal :D_Ch2_Rgn_R
      t.decimal :D_Ch2_Log_Ratio
      t.decimal :D_Sum_of_Medians
      t.decimal :D_Sum_of_Means
      t.decimal :D_Ch1_N_Median
      t.decimal :D_Ch1_N_Mean
      t.decimal :D_Ch1_N_MedianB
      t.decimal :D_Ch1_N_MeanB
      t.decimal :D_Ch2_N_Median
      t.decimal :D_Ch2_N_Mean
      t.decimal :D_Ch2_N_MedianB
      t.decimal :D_Ch2_N_MeanB
      t.decimal :D_Ch2_N_Ratio_of_Medians
      t.decimal :D_Ch2_N_Ratio_of_Means
      t.decimal :D_Ch2_N_Median_of_Ratios
      t.decimal :D_Ch2_N_Mean_of_Ratios
      t.decimal :D_Ch2_N_Rgn_Ratio
      t.decimal :D_Ch2_N_Log_Ratio

      t.timestamps
    end

    add_index :micro_array_datas, :microarray_id
end

  def self.down
    remove_index :micro_array_datas, :microarray_id
    drop_table :micro_array_datas
  end
end

