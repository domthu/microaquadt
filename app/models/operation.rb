class Operation < ActiveRecord::Base
  validates_presence_of :name, :message => "Can't be empty, field is mandatory. "
  validates_presence_of :step, :message => "Can't be empty, field is mandatory. "
  validates_numericality_of :step, :allow_nil => false, :less_than => 100

  belongs_to :protocol

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.name + ' ' + self.step.to_s
  end
end

