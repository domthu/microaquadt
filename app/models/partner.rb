class Partner < ActiveRecord::Base
	validates_presence_of :fp7_Number, :name, :email

  EmailRegex = /\A[\w+\-._]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of   :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false

	has_many :person
  has_many :sampling

  attr_reader :verbose_me
  def verbose_me
    return self.fp7_Number.to_s + ' - ' + self.name
  end

end

