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
  has_many :microposts

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
  #def self.authenticate(email, submitted_password)
  def self.authenticate(name, submitted_password)
    #Exist class method find_by_email because INDEX on column
    #user = find_by_email(email)
    # add_index :users, :name, :unique => true
    user = find_by_name(name)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  #Use in sign_in function in the Session HELPER
  def remember_me!
    #Here we set the remember token for each user using the encrypt function.
    #Since this token will be placed on the user’s browser,
    #it needs to be both unique and secure.
    #We accomplish this by encrypting the salt with the id,
    self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
    #we’ll store the remember token in the database
    #and at some point use the find_by_remember_token method
    #But the validations will fail if we simply use save (no virtual password attribute which is required)
    save_without_validation
  end

  private

    #use by create new user (with all parameters required for saving)
    #use by sign in method during storing remember_me data.
    #But: Even though we skip the validation step using save_without_validation,
    #the before_save callback still fires causing encrypt_password faillure --> unless password.nil?
    def encrypt_password
      unless password.nil? #due to def remember_me! method during sign in function call
        #self.password) --> inside the User class, the user object is just self, and we could write
        self.salt = make_salt
        self.encrypted_password = encrypt(password)
        #self is not optional when assigning to an attribute, so we have to write self.encrypted_password in this case
      end
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

