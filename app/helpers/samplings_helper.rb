module SamplingsHelper

include CodeTypesHelper
#retrieve user from partner see function auth_user(pid) in code_types_helper.rb

  #retrieve user from partner from sampling
  def auth_sample_user(sid)
    @sampling = Sampling.find(sid)
    return auth_user(@sampling.partner_id)
  end

end

