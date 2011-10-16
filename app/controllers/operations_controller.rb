class OperationsController < ApplicationController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update]

  # GET /operations
  # GET /operations.xml
  def index
    @operations = Operation.all
    @title = "List of operations"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @operations }
    end
  end

  # GET /operations/1
  # GET /operations/1.xml
  def show
    @operation = Operation.find(params[:id])
    @title = "Operation"

    if @operation.nil?
        redirect_to :action => "index"
    end

    @prot = Protocol.find(@operation.protocol_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @operation }
    end
  end

  # GET /operations/new
  # GET /operations/new.xml
  def new
    @operation = Operation.new
    @title = "Operation"


    @prot_c = Protocol.count()
    if @prot_c.nil? or @prot_c == 0
      flash[:error] = "No protocol found! create first some..."
      redirect_to :action => "index"
      return
    end

    @pt = Partner.find(:first, :conditions => [ "user_id = ?", current_user.id])
    @prot = Protocol.all()
#    if @pt.nil?
#      @prot = Protocol.all()
#    else
#      @sampling = Sampling.all(:conditions => [ "partner_id = ?", @pt.id])
#      # TODO fare condition di tipo protocol_id in (lista ids)  
#      @prot = Protocol.all(:conditions => [ "protocol_id = ?",  @sampling.protocol_id])
#    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @operation }
    end
  end

  # GET /operations/1/edit
  def edit
    @operation = Operation.find(params[:id])
    @title = "Operation"
    @prot = Sampling.find(@operation.protocol_id)
  end

  # POST /operations
  # POST /operations.xml
  def create
    @operation = Operation.new(params[:operation])
    @title = "Operation"

    respond_to do |format|
      if @operation.save
        format.html { redirect_to(@operation, :notice => 'Operation was successfully created.') }
        format.xml  { render :xml => @operation, :status => :created, :location => @operation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @operation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /operations/1
  # PUT /operations/1.xml
  def update
    @operation = Operation.find(params[:id])
    @title = "Operation"

    respond_to do |format|
      if @operation.update_attributes(params[:operation])
        format.html { redirect_to(@operation, :notice => 'Operation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @operation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1
  # DELETE /operations/1.xml
  def destroy
    @operation = Operation.find(params[:id])
    @operation.destroy
    @title = "Operation"

    respond_to do |format|
      format.html { redirect_to(operations_url) }
      format.xml  { head :ok }
    end
  end

  private

    def correct_user
      @op = Operation.find(params[:id])
      @prot = Protocol.find(@op.protocol_id)
      @sampling = Sampling.find(@prot.sampling_id)
      @partner = Partner.find(@sampling.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the operation can modify it."
      redirect_to(operations_path)
    end

end

