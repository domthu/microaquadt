class MicroArrayValidation < ActiveRecord::Base

  validates_numericality_of :CellCount, :allow_nil => true, :less_than => 100
  validates_numericality_of :QPCR_decimal, :allow_nil => true, :less_than => 100
  validates_numericality_of :QPCR_Culture, :allow_nil => true, :less_than => 100
  validates_numericality_of :Chemscan, :allow_nil => true, :less_than => 100

  belongs_to :microarraydata
  belongs_to :experiment

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.CellCount.to_s
  end
end

