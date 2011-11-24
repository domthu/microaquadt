class OligoSequence < ActiveRecord::Base
  validates_presence_of :name, :message => "Can't be empty, field is mandatory. "
  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :DNA_Sequence, :message => "Can't be empty, field is mandatory. "
  validates_uniqueness_of :DNA_Sequence, :case_sensitive => false

  belongs_to :partner
  belongs_to :tax_id, :class_name => "Name"
  validates_presence_of :partner_id, :tax_id_id
  validates_presence_of :partner

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.name + ' ' + self.tax_id.to_s
  end

end

