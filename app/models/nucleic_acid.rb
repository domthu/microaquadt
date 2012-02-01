class NucleicAcid < ActiveRecord::Base
  belongs_to :filter_sample
  belongs_to :nucleic_acid_type
  belongs_to :partner
end
