class NodesController < ApplicationController

  #solo superuser can do somthing on this ressource
  before_filter :correct_user, :only => [:edit, :update, :new, :create, :destroy]

  # GET /nodes
  # GET /nodes.xml
  def index
    @nodes = Node.all
    @title = "List of taxonomy nodes - Browse organisms"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nodes }
    end
  end

  # GET /nodes/1
  # GET /nodes/1.xml
  def show
    @node = Node.find(params[:id])
    @title = "Taxonomy node - organism relationships"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @node }
    end
  end

  # GET /nodes/new
  # GET /nodes/new.xml
  def new
    @node = Node.new
    @title = "Taxonomy node - organism relationships"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @node }
    end
  end

  # GET /nodes/1/edit
  def edit
    @node = Node.find(params[:id])
    @title = "Taxonomy node - organism relationships"
  end

  # POST /nodes
  # POST /nodes.xml
  def create
    @node = Node.new(params[:node])
    @title = "Taxonomy node - organism relationships"

    respond_to do |format|
      if @node.save
        format.html { redirect_to(@node, :notice => 'Node was successfully created.') }
        format.xml  { render :xml => @node, :status => :created, :location => @node }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @node.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nodes/1
  # PUT /nodes/1.xml
  def update
    @node = Node.find(params[:id])
    @title = "Taxonomy node - organism relationships"

    respond_to do |format|
      if @node.update_attributes(params[:node])
        format.html { redirect_to(@node, :notice => 'Node was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @node.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.xml
  def destroy
    @node = Node.find(params[:id])
    @node.destroy
    @title = "Taxonomy node - organism relationships"

    respond_to do |format|
      format.html { redirect_to(nodes_url) }
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

