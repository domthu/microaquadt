class BatchSampling < ActiveRecord::Base

 has_many :samplings, :dependent => :destroy

 has_many :sampling_assets, :dependent => :destroy

 accepts_nested_attributes_for :sampling_assets

 belongs_to :partner


end
