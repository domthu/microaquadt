class UsersController < AuthController
  #By default, before filters apply to every action in a controller,
  #so here we restrict the filter to act only on the :edit and :update actions
  #by passing the :only options hash.
  before_filter :authenticate, :only => [:index, :edit, :update]
  #only Requiring the right user to change own contents
  #before_filter :correct_user, :only => [:edit, :update, :new, :create, :destroy]
  #20110922 NC solo superuser can do somthing on user and partner
  before_filter :correct_user, :only => [:new, :create, :destroy]
  #20111017 NC user can change his own password
  before_filter :modify_user, :only => [:edit, :update]

  #do not write to log password
  filter_parameter_logging :password

  # GET /users
  # GET /users.xml
  def index
    @users = User.all
    @title = "users"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @title = @user.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  # map.signup '/signup',   :controller => 'users', :action => 'new'
  #Nell'applicazione Microaqua non ci devono essere registrazione di utente
  #quindi fare il redirect_to signin
  def new
    #Signup redirect to sign_in
    redirect_to signin_path

    #ATTENZIONE o fa render o fa redirect per una action
    ##use for form_for
    #@user = User.new
      if !current_user?(@user)
        flash[:notice] = "Only the partner who create the risorse can modify it."
      end
 #@title = "user"

    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.xml  { render :xml => @user }
    #end
  end

  # POST /users
  # POST /users.xml
  #def create
  #  @user = User.new(params[:user])
  #  @title = "user"
  #  respond_to do |format|
  #    if @user.save
  #      format.html { redirect_to(@user, :notice => 'User was successfully created.') }
  #      format.xml  { render :xml => @user, :status => :created, :location => @user }
  #    else
  #      format.html { render :action => "new" }
  #      format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end

  #user signup. POST
  #form_for introduce create action
  def create
    @title = "sign up user"
    #params variable in a console session
    @user = User.new(params[:user])  #hash of user attributes
    # A create action that can handle signup failure
    if @user.save
      #Automatically sign in the new created user
      sign_in @user

      flash[:success] = "Welcome to the microaqua bio application!"
      # Handle a successful save.
      redirect_to @user  #equal as user_path(@user)
    else
      @title = "Sign up"
      render 'new'
    end
  end


  # GET /users/1/edit
  def edit
    #Removing the superfluous @user variable assignments.
    #@user = User.find(params[:id])  --> Yet done in def correct_user
    @title = @user.name #"user"
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    #Removing the superfluous @user variable assignments.
    #@user = User.find(params[:id])  --> Yet done in def correct_user
    @title = @user.name #"user"

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end

    #respond_to do |format|
    #  if @user.update_attributes(params[:user])
    #    format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
    #    format.xml  { head :ok }
    #  else
    #    format.html { render :action => "edit" }
    #    format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    redirect_to users_path
    #@user = User.find(params[:id])
    #@user.destroy
    #@title = @user.name #"user"

    #respond_to do |format|
    #  format.html { redirect_to(users_url) }
    #  format.xml  { head :ok }
    #end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      #uses the current_user? method,
      #which (as with deny_access) we will define in the Sessions helper
      #reroute() unless current_user?(@user)
      #20110922 NC solo superuser can do somthing on user and partner
      reroute() unless signed_in_and_master?
    end

    def modify_user
      @user = User.find(params[:id])
      reroute() unless (current_user?(@user) or signed_in_and_master?)
    end

    def reroute()
      flash[:notice] = "Only the partner can modify his own profile."
      redirect_to(user_path(@user))
    end
end

