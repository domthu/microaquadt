class CreateGprDatas < ActiveRecord::Migration
  def self.up
    create_table :gpr_datas do |t|

      t.references :microarraygpr
      t.references :gpr_header
      t.references :gal_block
      t.string :oligo_row
      t.string :oligo_column
      t.string :oligo_id
      t.string :oligo_name
      t.string :x
      t.string :y
      t.string :dia
      t.string :f635_median
      t.string :f635_mean
      t.string :f635_sd
      t.string :f635_cv
      t.string :b635
      t.string :b635_Median
      t.string :b635_mean
      t.string :b635_sd
      t.string :b635_cv
      t.string :percent_b635_1_sd
      t.string :percent_b635_2_sd
      t.string :f635_perc_sat
      t.string :f532_median
      t.string :f532_mean
      t.string :f532_sd
      t.string :f532_cv
      t.string :b532
      t.string :b532_median
      t.string :b532_mean
      t.string :b532_sd
      t.string :b532_cv
      t.string :percent_b532_1_sd
      t.string :percent_b532_2_sd
      t.string :f532_perc_sat
      t.string :ratio_of_medians
      t.string :ratio_of_means
      t.string :median_of_ratios
      t.string :mean_of_ratios
      t.string :ratios_sd
      t.string :rgn_ratio
      t.string :rgn_r2
      t.string :f_pixels
      t.string :b_pixels
      t.string :circularity
      t.string :sum_of_medians
      t.string :sum_of_means
      t.string :log_ratio
      t.string :f635_median_minus_b635
      t.string :f532_median_minus_b635
      t.string :f635_mean_minus_b635
      t.string :f532_mean_minus_b635
      t.string :f635_total_intensity
      t.string :f532_total_intensity
      t.string :snr_635
      t.string :snr_532
      t.string :flags
      t.string :normalize
      t.string :autoflag
      

      t.timestamps
    end
  end

  def self.down
    drop_table :gpr_datas
  end
end
