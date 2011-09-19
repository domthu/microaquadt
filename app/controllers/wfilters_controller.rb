class WfiltersController < ApplicationController
  # GET /wfilters
  # GET /wfilters.xml
  def index
    @wfilters = Wfilter.all
    @title = "filters"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wfilters }
    end
  end

  # GET /wfilters/1
  # GET /wfilters/1.xml
  def show
    @wfilter = Wfilter.find(params[:id])
    @title = "filters"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wfilter }
    end
  end

  # GET /wfilters/new
  # GET /wfilters/new.xml
  def new
    @wfilter = Wfilter.new
    @title = "filter"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wfilter }
    end
  end

  # GET /wfilters/1/edit
  def edit
    @wfilter = Wfilter.find(params[:id])
  end

  # POST /wfilters
  # POST /wfilters.xml
  def create
    @wfilter = Wfilter.new(params[:wfilter])
    @title = "filter"

    respond_to do |format|
      if @wfilter.save
        format.html { redirect_to(@wfilter, :notice => 'Wfilter was successfully created.') }
        format.xml  { render :xml => @wfilter, :status => :created, :location => @wfilter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wfilter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wfilters/1
  # PUT /wfilters/1.xml
  def update
    @wfilter = Wfilter.find(params[:id])
    @title = "filter"

    respond_to do |format|
      if @wfilter.update_attributes(params[:wfilter])
        format.html { redirect_to(@wfilter, :notice => 'Wfilter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wfilter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wfilters/1
  # DELETE /wfilters/1.xml
  def destroy
    @wfilter = Wfilter.find(params[:id])
    @wfilter.destroy
    @title = "filter"

    respond_to do |format|
      format.html { redirect_to(wfilters_url) }
      format.xml  { head :ok }
    end
  end
end

