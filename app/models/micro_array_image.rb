class MicroArrayImage < ActiveRecord::Base
	validates_presence_of :name, :message => "Can't be empty, field is mandatory. "
	validates_length_of   :name, :maximum => 50

  belongs_to :microarraydata
  belongs_to :experiment

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.name
  end
end

