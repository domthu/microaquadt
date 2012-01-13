

namespace :db do
  desc "Empty existing data from OligoSequence and Fill database with default sample filter data"
  task :addperson => :environment do

#    existing_persons = Person.all()
#    for ps in existing_persons do
#        ps.destroy
#    end

# insert all people
#      t.string :firstname, :null => false
#      t.string :lastname, :null => false
#      t.string :phone
#      t.string :email, :null => false
#      t.string :town
#      t.binary :avatar

Person.create!( :firstname => "DE SIMONE", :lastname =>"Simona", :phone => "", :email => "simona.desimone@unicam.it", :town =>"CAMERINO")
Person.create!( :firstname => "GUALERZI", :lastname =>"Claudio", :phone => "", :email => "claudio.gualerzi@unicam.it", :town =>"CAMERINO")
Person.create!( :firstname => "SPURIO", :lastname =>"Roberto", :phone => "", :email => "roberto.spurio@unicam.it", :town =>"CAMERINO")
Person.create!( :firstname => "HAYES", :lastname =>"Paul Kelvin", :phone => "", :email => "paul.hayes@port.ac.uk", :town =>"PORTSMOUTH")
Person.create!( :firstname => "MEDLIN", :lastname =>"Linda", :phone => "", :email => "medlin@obs-banyuls.fr", :town =>"BANYULS")
Person.create!( :firstname => " GUILLEBAULT", :lastname =>"Delphine", :phone => "", :email => "delphine.guillebault@obs-banyuls.fr", :town =>"BANYULS")
Person.create!( :firstname => "HELMI", :lastname =>"Karim", :phone => "", :email => "karim.helmi@veolia.com", :town =>"PARIS")
Person.create!( :firstname => "MANCINI", :lastname =>"Laura", :phone => "", :email => "laura.mancini@iss.it", :town =>"ROMA")
Person.create!( :firstname => "HOLDEN", :lastname =>"Nicholas", :phone => "", :email => "nick.holden@ucd.ie", :town =>"DUBLIN")
Person.create!( :firstname => "PANAIOTOV", :lastname =>"Stefan", :phone => "", :email => "spanaiotov@yahoo.com", :town =>"SOFIA")
Person.create!( :firstname => "ELLIOTT", :lastname =>"Christopher", :phone => "", :email => "chris.elliott@qub.ac.uk", :town =>"BELFAST")
Person.create!( :firstname => "MEYER", :lastname =>"Thomas", :phone => "", :email => "tmeyer@marilim.de", :town =>"TIEV")
Person.create!( :firstname => "ALBAY", :lastname =>"MERIÇ", :phone => "", :email => "albay.hermano@gmail.com", :town =>"ISTANBUL")
Person.create!( :firstname => "AMPARO", :lastname =>"Alfonso", :phone => "", :email => "amparo.alfonso@usc.es", :town =>"SANTIAGO DE COMPOSTELA")
Person.create!( :firstname => "WEIGEL", :lastname =>"Wilfried", :phone => "", :email => "weigel@scienion.de", :town =>"BERLIN")
Person.create!( :firstname => "DEZY", :lastname =>"dezy", :phone => "", :email => "dezy.dezy@unicam.it", :town =>"CAMERINO")


# define people_partner relation
#      t.integer :partner_id
#      t.integer :person_id
#      t.boolean :IsPrincipalInvestigator
#      t.boolean :IsAdministratorResponsable

PartnerPerson.create!( :partner_id => 1, :person_id =>1, :IsPrincipalInvestigator => 0, :IsAdministratorResponsable => 1) 
PartnerPerson.create!( :partner_id => 1, :person_id =>2, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 1, :person_id =>3, :IsPrincipalInvestigator => 0, :IsAdministratorResponsable => 1) 
PartnerPerson.create!( :partner_id => 2, :person_id =>4, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 3, :person_id =>5, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 3, :person_id =>6, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 4, :person_id =>7, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 5, :person_id =>8, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 6, :person_id =>9, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 7, :person_id =>10, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 8, :person_id =>11, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 9, :person_id =>12, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 10, :person_id =>13, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 11, :person_id =>14, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 12, :person_id =>15, :IsPrincipalInvestigator => 1, :IsAdministratorResponsable => 0) 
PartnerPerson.create!( :partner_id => 1, :person_id =>16, :IsPrincipalInvestigator => 0, :IsAdministratorResponsable => 0) 

  end
end

