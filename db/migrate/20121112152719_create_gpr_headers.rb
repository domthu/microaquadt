class CreateGprHeaders < ActiveRecord::Migration
  def self.up
    create_table :gpr_headers do |t|

      t.string :gprVersion
      t.string :number_data_column
      t.string :gprtype
      t.string :datetime
      t.string :settings
      t.string :galfile
      t.string :pixelsize
      t.string :wavelengths
      t.string :imagefiles
      t.string :normalizationmethod
      t.string :normalizationfactors
      t.string :jpegimage
      t.string :stddev
      t.string :ratioformulations
      t.string :featuretype
      t.string :barcode
      t.string :backgroundsubtraction
      t.string :imageorigin
      t.string :jpegorigin
      t.string :creator
      t.string :scanner
      t.string :focusposition
      t.string :temp
      t.string :linesavg
      t.string :comment
      t.string :pmtgain
      t.string :scanpower
      t.string :laserpower
      t.string :filters
      t.string :scanregion
      t.string :supplier

      t.references :microarraygpr

      t.timestamps
    end
  end

  def self.down
    drop_table :gpr_headers
  end
end
