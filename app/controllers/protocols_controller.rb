class ProtocolsController < AuthController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update]


  # GET /protocols
  # GET /protocols.xml
  def index
    @protocols = Protocol.all
    @title = "List of protocols"

    if @protocols.nil?
        redirect_to :action => "index"
    end

      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @protocols }
    end
  end

  # GET /protocols/1
  # GET /protocols/1.xml
  def show
    @protocol = Protocol.find(params[:id])
    @title = "Protocols"

    @s = Sampling.find(@protocols.sampling_id)
    @pt = Partner.find(@s.partner_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @protocol }
    end
  end

  # GET /protocols/new
  # GET /protocols/new.xml
  def new
    @protocol = Protocol.new
    @title = "Protocol"

    @s_c = Sampling.count()
    if @s_c.nil? or @s_c == 0
      flash[:error] = "No sampling found! create first some..."
      redirect_to :action => "index"
      return
    end

    @pt = Partner.find(:first, :conditions => [ "user_id = ?", current_user.id])
    if @pt.nil?
      @s = Sampling.all()
    else
      @s = Sampling.all(:conditions => [ "partner_id = ?", @pt.id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @protocol }
    end
  end

  # GET /protocols/1/edit
  def edit
    @protocol = Protocol.find(params[:id])
    @title = "Protocol"
    @s = Sampling.find(@protocol.sampling_id)
  end

  # POST /protocols
  # POST /protocols.xml
  def create
    @protocol = Protocol.new(params[:protocol])
    @title = "Protocol"

    respond_to do |format|
      if @protocol.save
        format.html { redirect_to(@protocol, :notice => 'Protocol was successfully created.') }
        format.xml  { render :xml => @protocol, :status => :created, :location => @protocol }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @protocol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /protocols/1
  # PUT /protocols/1.xml
  def update
    @protocol = Protocol.find(params[:id])
    @title = "Protocol"

    respond_to do |format|
      if @protocol.update_attributes(params[:protocol])
        format.html { redirect_to(@protocol, :notice => 'Protocol was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @protocol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /protocols/1
  # DELETE /protocols/1.xml
  def destroy
    @protocol = Protocol.find(params[:id])
    @protocol.destroy
    @title = "Protocol"

    respond_to do |format|
      format.html { redirect_to(protocols_url) }
      format.xml  { head :ok }
    end
  end

  private

    def correct_user
      @prot = Protocol.find(params[:id])
      @sampling = Sampling.find(@prot.sampling_id)
      @partner = Partner.find(@sampling.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the protocol can modify it."
      redirect_to(protocols_path)
    end

end

