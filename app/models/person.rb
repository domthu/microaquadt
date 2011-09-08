class Person < ActiveRecord::Base
  validates_presence_of :firstname, :LastName
  belongs_to :user
end
