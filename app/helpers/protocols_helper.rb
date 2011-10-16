module ProtocolsHelper

#retrieve user from partner via sampling see function auth_sample_user(pid) in micro_array_helper.rb

  #retrieve user from partner from sample from protocol
  def auth_prot_sample_user(protocol_id)
    @prot = Protocol.find(protocol_id)
    return auth_sample_user(@prot.sampling_id)
  end

end

