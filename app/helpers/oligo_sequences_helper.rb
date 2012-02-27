module OligoSequencesHelper

include CodeTypesHelper
#include SessionsHelper

require 'bio'
srv = Bio::NCBI::REST::EFetch
#    srv.default_email = "dom_thual@yahoo.fr"
#    srv.default_tool = "unicamBio"
Bio::NCBI.default_email ||= 'dom_thual@yahoo.fr'
Bio::NCBI.default_tool ||= 'unicamBio'

#retrieve user from partner see function auth_user(pid) in code_types_helper.rb
  #retrieve user from partner from oligo sequence
  def auth_oligo_user(oid)
    @oligo = OligoSequence.find(oid)
    return auth_user(@oligo.partner_id)
#    @partner = Partner.find(@oligo.partner_id)
#    @user = User.find(@partner.user_id)
#    return (@user.id == current_user.id)
  end



  def resolve_dxhtml
    path_to_folder = RAILS_ROOT + "/public/stylesheets/dxhmltree/imgs"
    return path_to_folder
  end

#KAPPAO: due to migration and rails cannot construct association person --> people
#    <%= select :oligo_sequence,:people_id,Person.find(:all, :joins => [:partner_person], :conditions => ["partner_person.partner_id = ? ", @pt.id]).collect{|p| [p.verbose_me, p.id]}%>
    def peoples_by_partner
        #return Person.all()

        @pt = get_partner
        if @pt.nil?
            return nil
        else
            #return Person.find(:all, 
            #  :conditions => ['partner_people.partner_id = ?', @pt.id], 
            #  :joins => [:partner_people], 
            #  :select => 'DISTINCT people.*',
            #  :order => 'people.firstname')
            # PartnerPeople --> PartnerPerson
            #return arrays of id
            @asso = PartnerPerson.find(
                :all,
                :conditions => ["partner_id = ?", @pt.id],
                :select=>'person_id').map {|x| x.person_id}
            #return @asso
            #Object.find(:all,:select=>'id').map(&:id)
            if @asso.nil? or @asso.count() <= 0
                return nil
            else
                return Person.find_all_by_id(@asso)
            end
        end
    end
#ids = [2,3,5]
#Comment.find(ids)
#current_user.comments.find(ids)
#current_user.comments.select { |c| ids.include?(c.id) }


end

