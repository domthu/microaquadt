class SamplingSitesController < ApplicationController
  # GET /sampling_sites
  # GET /sampling_sites.xml

  #before_filter :find_water_use, :only => [:show, :edit, :update]
  #private def find_water_use
  #  #Model name
  #  @wu = WaterUse.find(params[:water_uses_id])
  #end

  def index
    @sampling_sites = SamplingSite.all
    @title = "Sampling sites"
    #@wu = WaterUse.find(@sampling_site.water_uses_id)
    #@wt = WaterType.find(@sampling_site.water_types_id)
    #@lum = LandUseMapping.find(@sampling_site.land_use_mappings_id)
    #@g = Geo.find(@sampling_site.geos_id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sampling_sites }
    end
  end

  # GET /sampling_sites/1
  # GET /sampling_sites/1.xml
  def show
    @sampling_site = SamplingSite.find(params[:id])
    if @sampling_site.nil?
        redirect_to :action => "index"
    end
    @title = "Sampling sites"
    @wu = WaterUse.find(@sampling_site.water_uses_id)
    @wt = WaterType.find(@sampling_site.water_types_id)
    @lum = LandUseMapping.find(@sampling_site.land_use_mappings_id)
    @g = Geo.find(@sampling_site.geos_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sampling_site }
    end
  end

  # GET /sampling_sites/new
  # GET /sampling_sites/new.xml
  def new
    @sampling_site = SamplingSite.new
    @title = "Sampling site"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sampling_site }
    end
  end

  # GET /sampling_sites/1/edit
  def edit
    @sampling_site = SamplingSite.find(params[:id])
    @title = "Sampling site"
  end

  # POST /sampling_sites
  # POST /sampling_sites.xml
  def create
    @sampling_site = SamplingSite.new(params[:sampling_site])
    @title = "Sampling site"

    respond_to do |format|
      if @sampling_site.save
        format.html { redirect_to(@sampling_site, :notice => 'SamplingSite was successfully created.') }
        format.xml  { render :xml => @sampling_site, :status => :created, :location => @sampling_site }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sampling_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sampling_sites/1
  # PUT /sampling_sites/1.xml
  def update
    @sampling_site = SamplingSite.find(params[:id])
    @title = "Sampling site"

    respond_to do |format|
      if @sampling_site.update_attributes(params[:sampling_site])
        format.html { redirect_to(@sampling_site, :notice => 'SamplingSite was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sampling_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sampling_sites/1
  # DELETE /sampling_sites/1.xml
  def destroy
    @sampling_site = SamplingSite.find(params[:id])
    @sampling_site.destroy
    @title = "Sampling site"

    respond_to do |format|
      format.html { redirect_to(sampling_sites_url) }
      format.xml  { head :ok }
    end
  end
end

