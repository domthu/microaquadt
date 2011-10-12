module OperationsHelper

  #retrieve user from partner from sample
  def auth_sample(protocol_id)
    @prot = Protocol.find(protocol_id)
    @sampling = Sampling.find(@prot.sampling_id)
    @partner = Partner.find(@sampling.partner_id)
    @user = User.find(@partner.user_id)
    @auth_sample = (@user.id == current_user.id)
  end

  def related_partner(protocol_id)
    @prot = Protocol.find(protocol_id)
    @sampling = Sampling.find(@prot.sampling_id)
    @partner = Partner.find(@sampling.partner_id)
    @related_partner = @partner.verbose_me
  end

end

