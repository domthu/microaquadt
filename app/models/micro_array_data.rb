class MicroArrayData < ActiveRecord::Base
	validates_presence_of :gpr_title, :message => "Can't be empty, field is mandatory. "
	validates_length_of   :gpr_title, :maximum => 300
  #insert it during loading file
	validates_presence_of :gpr_file_title, :message => "Can't be empty, field is mandatory. "

  belongs_to :partner
  belongs_to :experiment

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    #return self.gpr_title + ' ' + self.loaded_at.to_s
    return self.gpr_title + ' ' + self.loaded_at.strftime("%y%m%d")
  end
end

