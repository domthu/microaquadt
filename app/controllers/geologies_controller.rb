class GeologiesController < ApplicationController
  # GET /geologies
  # GET /geologies.xml
  def index
    @geologies = Geology.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @geologies }
    end
  end

  # GET /geologies/1
  # GET /geologies/1.xml
  def show
    @geology = Geology.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @geology }
    end
  end

  # GET /geologies/new
  # GET /geologies/new.xml
  def new
    @geology = Geology.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @geology }
    end
  end

  # GET /geologies/1/edit
  def edit
    @geology = Geology.find(params[:id])
  end

  # POST /geologies
  # POST /geologies.xml
  def create
    @geology = Geology.new(params[:geology])

    respond_to do |format|
      if @geology.save
        format.html { redirect_to(@geology, :notice => 'Geology was successfully created.') }
        format.xml  { render :xml => @geology, :status => :created, :location => @geology }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @geology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /geologies/1
  # PUT /geologies/1.xml
  def update
    @geology = Geology.find(params[:id])

    respond_to do |format|
      if @geology.update_attributes(params[:geology])
        format.html { redirect_to(@geology, :notice => 'Geology was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @geology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /geologies/1
  # DELETE /geologies/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to geologies_path
    else

        @ss = SamplingSite.find(:first, :conditions => [ "geologies_id = ?", params[:id]])
        if !@ss.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @geology = Geology.find(params[:id])
        @geology.destroy

        respond_to do |format|
          format.html { redirect_to(geologies_url) }
          format.xml  { head :ok }
        end
    end
  end
end
