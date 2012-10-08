class CreateExperiments < ActiveRecord::Migration
  def self.up
    create_table :experiments do |t|
      t.references :filter_sample
      t.references :microarraygal
      t.references :partner
      t.string :ecode
      t.string :barcode
      t.date :experiment_date
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :experiments
  end
end
