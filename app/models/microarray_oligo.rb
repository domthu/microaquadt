class MicroarrayOligo < ActiveRecord::Base

  #validates_presence_of :oligo_sequence_id, :message => "Can't be empty, field is mandatory. "
  validates_presence_of :microarraygal_id, :message => "Can't be empty, field is mandatory. "

  belongs_to :oligo_sequence
  belongs_to :microarraygal
   




end
