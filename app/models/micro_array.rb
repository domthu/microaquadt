class MicroArray < ActiveRecord::Base
  validates_presence_of :gpr_title
  validates_presence_of :gpr_file_title
  validates_presence_of :gpr_file

  belongs_to :partner

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.gpr_file_title
  end
end

