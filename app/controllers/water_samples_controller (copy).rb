class WaterSamplesController < ApplicationController
  #layout : "application"
  # GET /water_samples
  # GET /water_samples.xml
  def index
    @title = "water samples"
	@water_samples = WaterSample.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @water_samples }
    end
  end

  # GET /water_samples/1
  # GET /water_samples/1.xml
  def show
	@title = "water sample"
	@water_sample = WaterSample.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @water_sample }
    end
  end

  # GET /water_samples/new
  # GET /water_samples/new.xml
  def new
    @title = "water sample"
	@water_sample = WaterSample.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @water_sample }
    end
  end

  # GET /water_samples/1/edit
  def edit
    @title = "water sample"
	@water_sample = WaterSample.find(params[:id])
  end

  # POST /water_samples
  # POST /water_samples.xml
  def create
    @title = "water sample"
	@water_sample = WaterSample.new(params[:water_sample])

    respond_to do |format|
      if @water_sample.save
        format.html { redirect_to(@water_sample, :notice => 'WaterSample was successfully created.') }
        format.xml  { render :xml => @water_sample, :status => :created, :location => @water_sample }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @water_sample.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /water_samples/1
  # PUT /water_samples/1.xml
  def update
    @title = "water sample"
	@water_sample = WaterSample.find(params[:id])

    respond_to do |format|
      if @water_sample.update_attributes(params[:water_sample])
        format.html { redirect_to(@water_sample, :notice => 'WaterSample was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @water_sample.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /water_samples/1
  # DELETE /water_samples/1.xml
  def destroy
    @title = "water sample"
	@water_sample = WaterSample.find(params[:id])
    @water_sample.destroy

    respond_to do |format|
      format.html { redirect_to(water_samples_url) }
      format.xml  { head :ok }
    end
  end
end
