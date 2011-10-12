class Node < ActiveRecord::Base
  has_one :tax_id, :class_name => "Name"
  has_one :parent_tax_id, :class_name => "Name"

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return  self.tax_id.to_s + ' ' + self.parent_tax_id.to_s
  end

end

