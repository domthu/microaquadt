class MeteorologicalDatasController < ApplicationController
  # GET /meteorological_datas
  # GET /meteorological_datas.xml
  def index
    @meteorological_datas = MeteorologicalData.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @meteorological_datas }
    end
  end

  # GET /meteorological_datas/1
  # GET /meteorological_datas/1.xml
  def show
    @meteorological_data = MeteorologicalData.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @meteorological_data }
    end
  end

  # GET /meteorological_datas/new
  # GET /meteorological_datas/new.xml
  def new
    @meteorological_data = MeteorologicalData.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @meteorological_data }
    end
  end

  # GET /meteorological_datas/1/edit
  def edit
    @meteorological_data = MeteorologicalData.find(params[:id])
  end

  # POST /meteorological_datas
  # POST /meteorological_datas.xml
  def create
    @meteorological_data = MeteorologicalData.new(params[:meteorological_data])

    respond_to do |format|
      if @meteorological_data.save
        format.html { redirect_to(@meteorological_data, :notice => 'MeteorologicalData was successfully created.') }
        format.xml  { render :xml => @meteorological_data, :status => :created, :location => @meteorological_data }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @meteorological_data.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /meteorological_datas/1
  # PUT /meteorological_datas/1.xml
  def update
    @meteorological_data = MeteorologicalData.find(params[:id])

    respond_to do |format|
      if @meteorological_data.update_attributes(params[:meteorological_data])
        format.html { redirect_to(@meteorological_data, :notice => 'MeteorologicalData was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @meteorological_data.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /meteorological_datas/1
  # DELETE /meteorological_datas/1.xml
  def destroy
    @meteorological_data = MeteorologicalData.find(params[:id])
    @meteorological_data.destroy

    respond_to do |format|
      format.html { redirect_to(meteorological_datas_url) }
      format.xml  { head :ok }
    end
  end
end
