module CodeTypesHelper

  #retrieve user from partner
  def auth_user(pid)
    @partner = Partner.find(pid)
    @user = User.find(@partner.user_id)
    @auth_user = (@user.id == current_user.id)
  end

end

