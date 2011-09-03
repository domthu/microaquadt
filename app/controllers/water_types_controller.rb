class WaterTypesController < ApplicationController
  # GET /water_types
  # GET /water_types.xml
  def index
    @water_types = WaterType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @water_types }
    end
  end

  # GET /water_types/1
  # GET /water_types/1.xml
  def show
    @water_type = WaterType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @water_type }
    end
  end

  # GET /water_types/new
  # GET /water_types/new.xml
  def new
    @water_type = WaterType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @water_type }
    end
  end

  # GET /water_types/1/edit
  def edit
    @water_type = WaterType.find(params[:id])
  end

  # POST /water_types
  # POST /water_types.xml
  def create
    @water_type = WaterType.new(params[:water_type])

    respond_to do |format|
      if @water_type.save
        format.html { redirect_to(@water_type, :notice => 'WaterType was successfully created.') }
        format.xml  { render :xml => @water_type, :status => :created, :location => @water_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @water_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /water_types/1
  # PUT /water_types/1.xml
  def update
    @water_type = WaterType.find(params[:id])

    respond_to do |format|
      if @water_type.update_attributes(params[:water_type])
        format.html { redirect_to(@water_type, :notice => 'WaterType was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @water_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /water_types/1
  # DELETE /water_types/1.xml
  def destroy
    @water_type = WaterType.find(params[:id])
    @water_type.destroy

    respond_to do |format|
      format.html { redirect_to(water_types_url) }
      format.xml  { head :ok }
    end
  end
end
