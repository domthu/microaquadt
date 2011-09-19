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

  #Call from SessionsController sign_out
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

end

