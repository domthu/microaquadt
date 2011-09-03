class CreatePartnerPeople < ActiveRecord::Migration
  def self.up
    create_table :partner_people do |t|
      t.references :partner
      t.references :person
      t.boolean :IsPrincipalInvestigator
      t.boolean :IsAdministratorResponsable

      t.timestamps
    end
  end

  def self.down
    drop_table :partner_people
  end
end
