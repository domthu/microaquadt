class Wfilter < ActiveRecord::Base
  #validates_presence_of :name
  validates_presence_of :pore_size
  validates_numericality_of :pore_size, :allow_nil => false, :less_than => 100

  has_many :filter_sample
  #belongs_to :sampling_site

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    if self.name != ""
        return self.name
    else
        return self.pore_size.to_s + ' ' + self.name
    end
  end

end

