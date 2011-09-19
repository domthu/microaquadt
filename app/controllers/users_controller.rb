class UsersController < ApplicationController
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
  def new
    #use for form_for
    @user = User.new
    @title = "user"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @title = @user.name #"user"
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


  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    @title = @user.name #"user"

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    @title = @user.name #"user"

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end

