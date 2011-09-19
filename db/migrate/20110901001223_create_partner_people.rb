class CreatePartnerPeople < ActiveRecord::Migration
  def self.up
    create_table :partner_people do |t|
      t.integer :partner_id
      #t.references :partner
      t.integer :person_id
      #t.references :person
      t.boolean :IsPrincipalInvestigator
      t.boolean :IsAdministratorResponsable

      t.timestamps
    end

    add_index :partner_people, :partner_id
    add_index :partner_people, :person_id

  end

  def self.down
    drop_table :partner_people
  end
end

