module ProtocolsHelper

  #retrieve user from partner from sample
  def auth_sample(sid)
    @sampling = Sampling.find(sid)
    @partner = Partner.find(@sampling.partner_id)
    @user = User.find(@partner.user_id)
    @auth_sample = (@user.id == current_user.id)
  end

  def related_partner(sid)
    @sampling = Sampling.find(sid)
    @partner = Partner.find(@sampling.partner_id)
    @related_partner = @partner.verbose_me
  end

end

