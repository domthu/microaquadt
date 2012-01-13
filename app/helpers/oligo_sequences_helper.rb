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



end

