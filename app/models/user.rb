# == Schema Information
# Schema version: <timestamp>
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  #create a virtual password attribute
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  EmailRegex = /\A[\w+\-._]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :name, :email
  validates_length_of   :name, :maximum => 50

  validates_format_of   :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false
  #has_many :microposts

  # Automatically create the virtual attribute 'password_confirmation'.
  #to reject users whose password and password confirmations don’t match
  validates_confirmation_of :password

  # Password validations.
  validates_presence_of :password
  #:within option, passing it the range1 1..40 to enforce the desired length constraints
  validates_length_of   :password, :within => 1..40

  #Here the encrypt_password callback delegates the actual encryption to an encrypt method
  before_save :encrypt_password

  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of submitted_password.
    encrypted_password == encrypt(submitted_password)
  end

  #The way to define a class method is to use the self keyword in the method definition
  def self.authenticate(email, submitted_password)
    #Exist class method find_by_email because INDEX on column
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private

    def encrypt_password
      #self.password) --> inside the User class, the user object is just self, and we could write
      self.salt = make_salt
      self.encrypted_password = encrypt(password)
      #self is not optional when assigning to an attribute, so we have to write self.encrypted_password in this case
    end

    def encrypt(string)
      secure_hash("#{salt}#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end

