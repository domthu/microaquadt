class AuthController < ApplicationController
  #By default, before filters apply to every action in a controller,
  #so here we restrict the filter to act only on the :edit and :update actions
  #by passing the :only options hash.
  before_filter :authenticate
  #only Requiring the right user to change own contents
  before_filter :correct_user_destroy, :only => [:destroy, :delete]



  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user_destroy
      deny_access_destroy unless signed_in_and_master?
    end

end

