class CreateMicroarraygprs < ActiveRecord::Migration
  def self.up
    create_table :microarraygprs do |t|

      t.string :gpr_title
      t.string :gpr_file_title
      t.binary :gpr_file
      t.string :code
      t.date :loaded_at
      t.string :barcode
      t.references :partner
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :microarraygprs
  end
end
