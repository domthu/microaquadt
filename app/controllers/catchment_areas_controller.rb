class CatchmentAreasController < ApplicationController
  # GET /catchment_areas
  # GET /catchment_areas.xml
  def index
    @catchment_areas = CatchmentArea.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catchment_areas }
    end
  end

  # GET /catchment_areas/1
  # GET /catchment_areas/1.xml
  def show
    @catchment_area = CatchmentArea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catchment_area }
    end
  end

  # GET /catchment_areas/new
  # GET /catchment_areas/new.xml
  def new
    @catchment_area = CatchmentArea.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catchment_area }
    end
  end

  # GET /catchment_areas/1/edit
  def edit
    @catchment_area = CatchmentArea.find(params[:id])
  end

  # POST /catchment_areas
  # POST /catchment_areas.xml
  def create
    @catchment_area = CatchmentArea.new(params[:catchment_area])

    respond_to do |format|
      if @catchment_area.save
        format.html { redirect_to(@catchment_area, :notice => 'CatchmentArea was successfully created.') }
        format.xml  { render :xml => @catchment_area, :status => :created, :location => @catchment_area }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catchment_area.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catchment_areas/1
  # PUT /catchment_areas/1.xml
  def update
    @catchment_area = CatchmentArea.find(params[:id])

    respond_to do |format|
      if @catchment_area.update_attributes(params[:catchment_area])
        format.html { redirect_to(@catchment_area, :notice => 'CatchmentArea was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catchment_area.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catchment_areas/1
  # DELETE /catchment_areas/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to catchment_areas_path
    else

        @ss = SamplingSite.find(:first, :conditions => [ "catchment_areas_id = ?", params[:id]])
        if !@ss.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @catchment_area = CatchmentArea.find(params[:id])
        @catchment_area.destroy

        respond_to do |format|
          format.html { redirect_to(catchment_areas_url) }
          format.xml  { head :ok }
        end
    end
  end
end
