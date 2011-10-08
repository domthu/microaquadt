class CodeType < ActiveRecord::Base
	validates_presence_of :code
	validates_length_of   :code, :maximum => 1
  validates_uniqueness_of :code, :case_sensitive => false
	validates_presence_of :name
	validates_length_of   :name, :maximum => 50

  belongs_to :partner  #, :null => false  --> Unknown key(s): null
  validates_presence_of :partner

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.code + ' ' + self.name
  end

end

