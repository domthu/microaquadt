class Protocol < ActiveRecord::Base
  validates_presence_of :name, :message => "Can't be empty, field is mandatory. "

  belongs_to :sampling
  has_many :operations, :dependent => :destroy

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.name
  end
end

