class SamplingsController < ApplicationController

  # GET /samplings
  # GET /samplings.xml
  def index
    @samplings = Sampling.all

    respond_to do |format|
      format.html # index.html.erbs directly,
      format.xml  { render :xml => @samplings }
    end
  end

  # GET /samplings/1
  # GET /samplings/1.xml
  def show
    @sampling = Sampling.find(params[:id])
    if @sampling.nil?
        redirect_to :action => "index"
    end
    @pt = Partner.find(@sampling.partner_id)
    @ss = SamplingSite.find(@sampling.sampling_site_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sampling }
    end
  end

  # GET /samplings/new
  # GET /samplings/new.xml
  def new
    @sampling = Sampling.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sampling }
    end
  end

  # GET /samplings/1/edit
  def edit
    @sampling = Sampling.find(params[:id])
  end

  # POST /samplings
  # POST /samplings.xml
  def create
    @sampling = Sampling.new(params[:sampling])
    @new_filter = params[:pfilter]
    unless @new_filter.nil? || @new_filter == 0
        #create new filter object
        #@obj_new_filter = Wfilter.new(:name => @new_filter)
        @obj_new_filter = Wfilter.create(:name => @new_filter)
        if @obj_new_filter.save
          #retrieve filter_id and associate to @sampling
          sampling.wfilter_id = @obj_new_filter.id
        end
    end

    respond_to do |format|
      if @sampling.save
        format.html { redirect_to(@sampling, :notice => 'Sampling was successfully created.') }
        format.xml  { render :xml => @sampling, :status => :created, :location => @sampling }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sampling.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /samplings/1
  # PUT /samplings/1.xml
  def update
    @sampling = Sampling.find(params[:id])

    respond_to do |format|
      if @sampling.update_attributes(params[:sampling])
        format.html { redirect_to(@sampling, :notice => 'Sampling was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sampling.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /samplings/1
  # DELETE /samplings/1.xml
  def destroy
    @sampling = Sampling.find(params[:id])
    @sampling.destroy

    respond_to do |format|
      format.html { redirect_to(samplings_url) }
      format.xml  { head :ok }
    end
  end
end

