module SessionsHelper

  def sign_in(user)
    #The remember_me! method. IN User Model
    user.remember_me!
    #the cookies utility can be used like a hash; (array) in this case, we define a hash-of-hashes
    cookies[:remember_token] = { :value   => user.remember_token,
                                 :expires => 20.years.from_now.utc }
    # 20.years.from_now.utc --> Fixnum (the base class for numbers): add custom methods but bedcaruf
    #create current_user, accessible in both controllers and views,
    #which will allow constructions such as <%= current_user.name %> and redirect_to current_user
    self.current_user = user
    #In the context of the Sessions helper, the self in self.current_user is the Sessions controller,
    #since the module is being included into the Application controller,
    #which is the base class for all the other controllers (including Sessions).
    #But there is no such variable as current_user right now; we need to define it.
  end

  #assignment. Ruby has a special syntax for defining such an assignment function
  def current_user=(user)
    #a method current_user= expressly designed to handle assignment to current_user
    @current_user = user
  end

  #retrieve current_user using coockie
  def current_user
    @current_user ||= user_from_remember_token #||= (“or equals”) assignment operator only if @current_user is undefined
  end

  def user_from_remember_token
    remember_token = cookies[:remember_token]
    User.find_by_remember_token(remember_token) unless remember_token.nil?
  end

  #define the required signed_in? boolean method. Use of the “not” operator !: a user is signed in
  #if current_user is not nil
  def signed_in?
    !current_user.nil?
  end

  def signed_in_and_master?
    signed_in? && (current_user.name == 'admin_microaqua'  ||  current_user.name == 'roberto')
  end

  #Call from SessionsController sign_out
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  #PROTECT PAGE using before_filter :authenticate, :only => [:edit, :update]
  def current_user?(user)
    user == current_user
  end

  def deny_access
    #storing the location of the request
    store_location  #Friendly forwarding
    flash[:notice] = "Please sign in to access this page."
    redirect_to signin_path
  end

  def deny_access_destroy
    flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
    redirect_to request.request_uri
  end

  #Friendly forwarding
  def store_location
    #puts the requested URL in the session variable under the key :return_to
    session[:return_to] = request.request_uri
  end

  #redirect to the requested URL if it exists, or some default URL otherwise.
  #This method is needed in the Session create action to redirect after successful signin
  def redirect_back_or(default)
    #redirect_to(session[:return_to] || default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil
  end
end

