class LandUseMappingsController < AuthController

  # GET /land_use_mappings
  # GET /land_use_mappings.xml

  layout 'application'

  def index
    @land_use_mappings = LandUseMapping.all
    @title = "land use mappings"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @land_use_mappings }
    end
  end

  # GET /land_use_mappings/1
  # GET /land_use_mappings/1.xml
  def show
    @land_use_mapping = LandUseMapping.find(params[:id])
    @title = "land use mappings"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @land_use_mapping }
    end
  end

  # GET /land_use_mappings/new
  # GET /land_use_mappings/new.xml
  def new
    @land_use_mapping = LandUseMapping.new
    @title = "land use mapping"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @land_use_mapping }
    end
  end

  # GET /land_use_mappings/1/edit
  def edit
    @land_use_mapping = LandUseMapping.find(params[:id])
    @title = "land use mapping"
  end

  # POST /land_use_mappings
  # POST /land_use_mappings.xml
  def create
    @land_use_mapping = LandUseMapping.new(params[:land_use_mapping])
    @title = "land use mapping"

    respond_to do |format|
      if @land_use_mapping.save
        format.html { redirect_to(@land_use_mapping, :notice => 'LandUseMapping was successfully created.') }
        format.xml  { render :xml => @land_use_mapping, :status => :created, :location => @land_use_mapping }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @land_use_mapping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /land_use_mappings/1
  # PUT /land_use_mappings/1.xml
  def update
    @land_use_mapping = LandUseMapping.find(params[:id])
    @title = "land use mapping"

    respond_to do |format|
      if @land_use_mapping.update_attributes(params[:land_use_mapping])
        format.html { redirect_to(@land_use_mapping, :notice => 'LandUseMapping was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @land_use_mapping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /land_use_mappings/1
  # DELETE /land_use_mappings/1.xml
  def destroy
    @land_use_mapping = LandUseMapping.find(params[:id])
    @land_use_mapping.destroy
    @title = "land use mapping"

    respond_to do |format|
      format.html { redirect_to(land_use_mappings_url) }
      format.xml  { head :ok }
    end
  end
end

