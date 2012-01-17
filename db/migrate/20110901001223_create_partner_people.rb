class CreatePartnerPeople < ActiveRecord::Migration
  def self.up

    #, :id => false see doc
    create_table :partner_people do |t|
      t.references :partner
      t.references :person
      t.boolean :IsPrincipalInvestigator
      t.boolean :IsAdministratorResponsable

      t.timestamps
    end

    add_index :partner_people, :partner_id
    add_index :partner_people, :person_id
    add_index :partner_people, [:partner_id, :person_id], :unique => true

  end

  def self.down
    remove_index :partner_people, :partner_id
    remove_index :partner_people, :person_id
    remove_index :partner_people, [:partner_id, :person_id]
    drop_table :partner_people
  end
end


#create_table :apples_oranges, :id => false do |t|
#  t.references :apple, :null => false
#  t.references :orange, :null => false
#end
## Adding the index can massively speed up join tables. Don't use the
## unique if you allow duplicates.
#add_index(:apples_oranges, [:apple_id, :orange_id], :unique => true)

#If you use the :unique => true on the index, then you should (in rails3) pass :uniq => true to has_and_belongs_to_many.
#More information: Rails Docs
#UPDATED 2010-12-13 I've updated it to remove the id and timestamps... Basically MattDiPasquale and nunopolonia are correct: There must not be an id and there must not be timestamps or rails won't allow has_and_belongs_to_many to work.
