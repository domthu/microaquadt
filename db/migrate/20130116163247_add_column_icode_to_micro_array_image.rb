class AddColumnIcodeToMicroArrayImage < ActiveRecord::Migration
  def self.up
    add_column :micro_array_images, :icode, :string
  end

  def self.down
    remove_column :micro_array_images, :icode
  end
end
