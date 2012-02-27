class Person < ActiveRecord::Base
  validates_presence_of :firstname, :lastname, :email, :message => "Can't be empty, field is mandatory. "

  EmailRegex = /\A[\w+\-._]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of   :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false

  belongs_to :user

  attr_reader :verbose_me
  def verbose_me
    #return '(' + self.id.to_s + ') ' + self.firstname.upcase + ' ' + self.lastname.capitalize
    return self.firstname.upcase + ' ' + self.lastname.capitalize
  end

end

