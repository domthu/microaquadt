module MicroArraysHelper

#retrieve user from partner see function auth_user(pid) in code_types_helper.rb

  #retrieve user from partner from microarray
  def auth_ma_user(maid)
    @ma = MicroArray.find(maid)
    return auth_user(@ma.partner_id)
  end

end

