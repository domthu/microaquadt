class CreatePartnerPeople < ActiveRecord::Migration
  def self.up
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

