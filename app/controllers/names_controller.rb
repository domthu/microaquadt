class NamesController < ApplicationController

  #solo superuser can do somthing on this ressource
  before_filter :correct_user, :only => [:edit, :update, :new, :create, :destroy]

  # GET /names
  # GET /names.xml
  def index
    @names = Name.all
    @title = "List of taxonomy - Organisms"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @names }
    end
  end

  # GET /names/1
  # GET /names/1.xml
  def show
    @name = Name.find(params[:id])
    @title = "Taxonomy - Organism"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @name }
    end
  end

  # GET /names/new
  # GET /names/new.xml
  def new
    @name = Name.new
    @title = "Taxonomy - Organism"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @name }
    end
  end

  # GET /names/1/edit
  def edit
    @name = Name.find(params[:id])
    @title = "Taxonomy - Organism"
  end

  # POST /names
  # POST /names.xml
  def create
    @name = Name.new(params[:name])
    @title = "Taxonomy - Organism"

    respond_to do |format|
      if @name.save
        format.html { redirect_to(@name, :notice => 'Name was successfully created.') }
        format.xml  { render :xml => @name, :status => :created, :location => @name }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @name.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /names/1
  # PUT /names/1.xml
  def update
    @name = Name.find(params[:id])
    @title = "Taxonomy - Organism"

    respond_to do |format|
      if @name.update_attributes(params[:name])
        format.html { redirect_to(@name, :notice => 'Name was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @name.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /names/1
  # DELETE /names/1.xml
  def destroy
    @name = Name.find(params[:id])
    @name.destroy
    @title = "Taxonomy - Organism"

    respond_to do |format|
      format.html { redirect_to(names_url) }
      format.xml  { head :ok }
    end
  end

  private

    def correct_user
      @partner = Partner.find(params[:id])
      @user = User.find(@partner.user_id)
      reroute() unless signed_in_and_master?
    end

    def reroute()
      flash[:notice] = "ressource not accessible for the moment"
      redirect_to(signin_path)
    end

end

