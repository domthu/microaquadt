class CreateWfilters < ActiveRecord::Migration
  def self.up
    create_table :wfilters do |t|
      t.string :name, :default => ""
      t.decimal :pore_size , :default => 0, :precision => 5, :scale => 3
      t.decimal :num_filters , :default => 0, :precision => 2, :scale => 0
      t.text :note
      t.timestamps
    end

    add_index :wfilters, [:pore_size, :num_filters], :unique => true, :name => 'wf_u'
  end

  def self.down
    remove_index :wfilters, :name => 'wf_u'

    drop_table :wfilters
  end
end

