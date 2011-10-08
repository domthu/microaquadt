class Partner < ActiveRecord::Base
	validates_presence_of :fp7_Number, :name, :email, :country_id
  #validates_length_of :state, :maximum=>2

  EmailRegex = /\A[\w+\-._]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of   :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false
   #validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

	has_many :person
  has_many :sampling
  has_one :country #, :null => false

  attr_reader :verbose
  def verbose
    return self.fp7_Number.to_s + ' - ' + self.code
  end

  attr_reader :verbose_me
  def verbose_me
    return self.fp7_Number.to_s + ' - ' + self.code #+ ' - ' + self.name
  end

end

