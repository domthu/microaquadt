class Partner < ActiveRecord::Base
	validates_presence_of :fp7_Number, :Name, :Email

  EmailRegex = /\A[\w+\-._]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of   :Email, :with => EmailRegex
  validates_uniqueness_of :Email, :case_sensitive => false

	has_many :person
end

