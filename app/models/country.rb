class Country < ActiveRecord::Base
  validates_length_of :code, :is => 2
  validates_uniqueness_of :code, :case_sensitive => false

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.code + ' ' + self.name
  end

end

