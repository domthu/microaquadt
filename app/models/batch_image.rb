class BatchImage < ActiveRecord::Base


  has_many :micro_array_images, :dependent => :destroy
  
  has_many :image_assets, :dependent => :destroy

  accepts_nested_attributes_for :image_assets

  belongs_to :partner


end
