class DepthsController < AuthController   # < ApplicationController
  # GET /depths
  # GET /depths.xml
  def index
    @depths = Depth.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @depths }
    end
  end

  # GET /depths/1
  # GET /depths/1.xml
  def show
    @depth = Depth.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @depth }
    end
  end

  # GET /depths/new
  # GET /depths/new.xml
  def new
    @depth = Depth.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @depth }
    end
  end

  # GET /depths/1/edit
  def edit
    @depth = Depth.find(params[:id])
  end

  # POST /depths
  # POST /depths.xml
  def create
    @depth = Depth.new(params[:depth])

    respond_to do |format|
      if @depth.save
        format.html { redirect_to(@depth, :notice => 'Depth was successfully created.') }
        format.xml  { render :xml => @depth, :status => :created, :location => @depth }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @depth.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /depths/1
  # PUT /depths/1.xml
  def update
    @depth = Depth.find(params[:id])

    respond_to do |format|
      if @depth.update_attributes(params[:depth])
        format.html { redirect_to(@depth, :notice => 'Depth was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @depth.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /depths/1
  # DELETE /depths/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to depths_path
    else

        @ss = SamplingSite.find(:first, :conditions => [ "depth_id = ?", params[:id]])
        if !@ss.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @depth = Depth.find(params[:id])
        @depth.destroy

        respond_to do |format|
          format.html { redirect_to(depths_url) }
          format.xml  { head :ok }
        end
    end
  end
end
