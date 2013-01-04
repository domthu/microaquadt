class BatchOligo < ActiveRecord::Base

    
    has_many :oligo_sequences, :dependent => :destroy

    has_many :assets, :dependent => :destroy

    accepts_nested_attributes_for :assets




end
