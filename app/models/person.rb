class Person < ActiveRecord::Base
  validates_presence_of :firstname, :LastName, :email

  EmailRegex = /\A[\w+\-._]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of   :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false

  belongs_to :user
end

