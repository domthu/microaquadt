class PartnerPerson < ActiveRecord::Base
  belongs_to :partner
  belongs_to :person
end
