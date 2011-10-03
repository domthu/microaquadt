class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def create
    @title = "create session"
    #we do not use params[:session][:email] --> params[:session][:username]
    user = User.authenticate(params[:session][:name],
                             params[:session][:password])
    if user.nil?
      # Create an error message and re-render the signin form.
      #User model error messages. Since
      #the session isn’t an Active Record model, this strategy won’t work here,
      #so instead we’ve put a message in the flash
      flash.now[:error] = "Invalid username/password combination."
      @title = "Sign in"
      #difference between flash and flash.now.
      #when rendering rather than redirecting we use flash.now instead of flash
      render 'new'
    else
      # Sign the user in and redirect to the user's show page.
      sign_in user
      #Friendly forwarding
      #redirect_to user
      @partner = @partner = Partner.find(:first, :conditions => [ "user_id = ?", user.id])
      #if !@partner.nil? && signed_in_and_master?
      #if !@partner.nil?
      #  redirect_back_or @partner
      #else
      #  redirect_back_or user
      #end
      redirect_back_or samplings_url
    end
  end

  def destroy
    @title = "Sign out"
    #As with the other authentication elements, we’ll put sign_out in the Sessions helper module
    sign_out
    redirect_to root_path
  end

end

