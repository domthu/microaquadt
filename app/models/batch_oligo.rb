class BatchOligo < ActiveRecord::Base

    
    has_many :oligo_sequences, :dependent => :destroy

    has_many :assets, :dependent => :destroy

    accepts_nested_attributes_for :assets

    belongs_to :partner

    belongs_to :person




end
