class PartnersController < AuthController

  #only Requiring the right user to change own contents
  #before_filter :correct_user, :only => [:edit, :update]
  #20110922 NC solo superuser can do somthing on user and partner
  before_filter :correct_user, :only => [:new, :create, :destroy]
  before_filter :modify_partner, :only => [:edit, :update]

  # GET /partners
  # GET /partners.xml
  def index
    @partners = Partner.all
    @title = "partners"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @partners }
    end
  end

  # GET /partners/1
  # GET /partners/1.xml
  def show
    @partner = Partner.find(params[:id])
    @title = "partners"
    @state = Country.find(@partner.country_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @partner }
    end
  end

  # GET /partners/new
  # GET /partners/new.xml
  def new
    #Non creare nuovi partners dentro l'applicazione
    redirect_to partners_path

    #@partner = Partner.new
    #@title = "partner"
    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.xml  { render :xml => @partner }
    #end
  end

  # GET /partners/1/edit
  def edit
    #@partner = Partner.find(params[:id])
    @title = "partner"
  end

  # POST /partners
  # POST /partners.xml
  def create
    @partner = Partner.new(params[:partner])
    @title = "partner"

    respond_to do |format|
      if @partner.save
        format.html { redirect_to(@partner, :notice => 'Partner was successfully created.') }
        format.xml  { render :xml => @partner, :status => :created, :location => @partner }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @partner.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /partners/1
  # PUT /partners/1.xml
  def update
    #@partner = Partner.find(params[:id])
    @title = "partner"

    respond_to do |format|
      if @partner.update_attributes(params[:partner])
        format.html { redirect_to(@partner, :notice => 'Partner was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @partner.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /partners/1
  # DELETE /partners/1.xml
  def destroy
    redirect_to partners_path

    #@partner = Partner.find(params[:id])
    #@partner.destroy
    #@title = "partner"

    #respond_to do |format|
    #  format.html { redirect_to(partners_url) }
    #  format.xml  { head :ok }
    #end
  end

  private

    def correct_user
      @partner = Partner.find(params[:id])
      @user = User.find(@partner.user_id)
      #uses the current_user? method,
      #which (as with deny_access) we will define in the Sessions helper
      #reroute() unless current_user?(@user)
      #20110922 NC solo superuser can do somthing on user and partner
      reroute() unless signed_in_and_master?
    end

    def modify_partner
      @partner = Partner.find(params[:id])
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner can modify his own identity card."
      redirect_to(partners_path)
    end

end

