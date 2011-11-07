class CreateMicroArrayDatas < ActiveRecord::Migration
  def self.up
    create_table :micro_array_datas do |t|
      t.references :microarray
      t.text :note
      t.decimal :D_Index, :precision => 8, :scale => 2
      t.decimal :D_Array_Row, :precision => 8, :scale => 2
      t.decimal :D_Array_Column, :precision => 8, :scale => 2
      t.decimal :D_Spot_Row, :precision => 8, :scale => 2
      t.decimal :D_Spot_Column, :precision => 8, :scale => 2
      t.decimal :D_Name, :precision => 8, :scale => 2
      t.decimal :D_ID, :precision => 8, :scale => 2
      t.decimal :D_X, :precision => 8, :scale => 2
      t.decimal :D_Y, :precision => 8, :scale => 2
      t.decimal :D_Diameter, :precision => 8, :scale => 2
      t.decimal :D_F_Pixels, :precision => 8, :scale => 2
      t.decimal :D_B_Pixels, :precision => 8, :scale => 2
      t.decimal :D_Footprint, :precision => 8, :scale => 2
      t.decimal :D_Flags, :precision => 8, :scale => 2
      t.decimal :D_Ch1_Median, :precision => 8, :scale => 2
      t.decimal :D_Ch1_Mean, :precision => 8, :scale => 2
      t.decimal :D_Ch1_SD, :precision => 8, :scale => 2
      t.decimal :D_Ch1_B_Median, :precision => 8, :scale => 2
      t.decimal :D_Ch1_B_Mean, :precision => 8, :scale => 2
      t.decimal :D_Ch1_B_SD, :precision => 8, :scale => 2
      t.decimal :D_Ch1_B_1_SD, :precision => 8, :scale => 2
      t.decimal :D_Ch1_B_2_SD, :precision => 8, :scale => 2
      t.decimal :D_Ch1_F_Sat, :precision => 8, :scale => 2
      t.decimal :D_Ch1_Median_B, :precision => 8, :scale => 2
      t.decimal :D_Ch1_Mean_B, :precision => 8, :scale => 2
      t.decimal :D_Ch1_SignalNoiseRatio, :precision => 8, :scale => 2
      t.decimal :D_Ch2_Median, :precision => 8, :scale => 2
      t.decimal :D_Ch2_Mean, :precision => 8, :scale => 2
      t.decimal :D_Ch2_SD, :precision => 8, :scale => 2
      t.decimal :D_Ch2_B_Median, :precision => 8, :scale => 2
      t.decimal :D_Ch2_B_Mean, :precision => 8, :scale => 2
      t.decimal :D_Ch2_B_SD, :precision => 8, :scale => 2
      t.decimal :D_Ch2_B_1_SD, :precision => 8, :scale => 2
      t.decimal :D_Ch2_B_2_SD, :precision => 8, :scale => 2
      t.decimal :D_Ch2_F_Sat, :precision => 8, :scale => 2
      t.decimal :D_Ch2_Median_B, :precision => 8, :scale => 2
      t.decimal :D_Ch2_Mean_B, :precision => 8, :scale => 2
      t.decimal :D_Ch2_SignalNoiseRatio, :precision => 8, :scale => 2
      t.decimal :D_Ch2_Ratio_of_Medians, :precision => 8, :scale => 2
      t.decimal :D_Ch2_Ratio_of_Means, :precision => 8, :scale => 2
      t.decimal :D_Ch2_Median_of_Ratios, :precision => 8, :scale => 2
      t.decimal :D_Ch2_Mean_of_Ratios, :precision => 8, :scale => 2
      t.decimal :D_Ch2_Ratios_SD, :precision => 8, :scale => 2
      t.decimal :D_Ch2_Rgn_Ratio, :precision => 8, :scale => 2
      t.decimal :D_Ch2_Rgn_R, :precision => 8, :scale => 2
      t.decimal :D_Ch2_Log_Ratio, :precision => 8, :scale => 2
      t.decimal :D_Sum_of_Medians, :precision => 8, :scale => 2
      t.decimal :D_Sum_of_Means, :precision => 8, :scale => 2
      t.decimal :D_Ch1_N_Median, :precision => 8, :scale => 2
      t.decimal :D_Ch1_N_Mean, :precision => 8, :scale => 2
      t.decimal :D_Ch1_N_MedianB, :precision => 8, :scale => 2
      t.decimal :D_Ch1_N_MeanB, :precision => 8, :scale => 2
      t.decimal :D_Ch2_N_Median, :precision => 8, :scale => 2
      t.decimal :D_Ch2_N_Mean, :precision => 8, :scale => 2
      t.decimal :D_Ch2_N_MedianB, :precision => 8, :scale => 2
      t.decimal :D_Ch2_N_MeanB, :precision => 8, :scale => 2
      t.decimal :D_Ch2_N_Ratio_of_Medians, :precision => 8, :scale => 2
      t.decimal :D_Ch2_N_Ratio_of_Means, :precision => 8, :scale => 2
      t.decimal :D_Ch2_N_Median_of_Ratios, :precision => 8, :scale => 2
      t.decimal :D_Ch2_N_Mean_of_Ratios, :precision => 8, :scale => 2
      t.decimal :D_Ch2_N_Rgn_Ratio, :precision => 8, :scale => 2
      t.decimal :D_Ch2_N_Log_Ratio, :precision => 8, :scale => 2

      t.timestamps
    end

    add_index :micro_array_datas, :microarray_id
end

  def self.down
    remove_index :micro_array_datas, :microarray_id
    drop_table :micro_array_datas
  end
end

