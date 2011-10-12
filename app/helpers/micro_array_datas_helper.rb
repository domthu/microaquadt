module MicroArrayDatasHelper

  #retrieve user from partner from sample
  def auth_sample(maid)
    @ma = MicroArray.find(maid)
    @partner = Partner.find(@ma.partner_id)
    @user = User.find(@partner.user_id)
    @auth_sample = (@user.id == current_user.id)
  end

  def related_partner(maid)
    @ma = MicroArray.find(maid)
    @partner = Partner.find(@ma.partner_id)
    @related_partner = @partner.verbose_me
  end

end

