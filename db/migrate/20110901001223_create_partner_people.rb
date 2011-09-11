class CreatePartnerPeople < ActiveRecord::Migration
  def self.up
    create_table :partner_people do |t|
      t.references :partners
      t.references :persons
      t.boolean :IsPrincipalInvestigator
      t.boolean :IsAdministratorResponsable

      t.timestamps
    end
  end

  def self.down
    drop_table :partner_people
  end
end
