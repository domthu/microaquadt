class Person < ActiveRecord::Base
  validates_presence_of :firstname, :LastName

  EmailRegex = /\A[\w+\-._]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of   :Email, :with => EmailRegex
  validates_uniqueness_of :Email, :case_sensitive => false

  belongs_to :user
end

