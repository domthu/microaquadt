class FilterSamplePreparationsController < AuthController

  layout 'application'

  # GET /filter_sample_preparations
  # GET /filter_sample_preparations.xml
  def index
    @title = "filter sample preparations"
    @filter_sample_preparations = FilterSamplePreparation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @filter_sample_preparations }
    end
  end

  # GET /filter_sample_preparations/1
  # GET /filter_sample_preparations/1.xml
  def show
    @title = "filter sample preparation"
    @filter_sample_preparation = FilterSamplePreparation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @filter_sample_preparation }
    end
  end

  # GET /filter_sample_preparations/new
  # GET /filter_sample_preparations/new.xml
  def new
    @title = "filter sample preparation"
    @filter_sample_preparation = FilterSamplePreparation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @filter_sample_preparation }
    end
  end

  # GET /filter_sample_preparations/1/edit
  def edit
    @title = "filter sample preparation"
    @filter_sample_preparation = FilterSamplePreparation.find(params[:id])
  end

  # POST /filter_sample_preparations
  # POST /filter_sample_preparations.xml
  def create
    @filter_sample_preparation = FilterSamplePreparation.new(params[:filter_sample_preparation])

    respond_to do |format|
      if @filter_sample_preparation.save
        format.html { redirect_to(@filter_sample_preparation, :notice => 'FilterSamplePreparation was successfully created.') }
        format.xml  { render :xml => @filter_sample_preparation, :status => :created, :location => @filter_sample_preparation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @filter_sample_preparation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /filter_sample_preparations/1
  # PUT /filter_sample_preparations/1.xml
  def update
    @title = "filter sample preparation"
    @filter_sample_preparation = FilterSamplePreparation.find(params[:id])

    respond_to do |format|
      if @filter_sample_preparation.update_attributes(params[:filter_sample_preparation])
        format.html { redirect_to(@filter_sample_preparation, :notice => 'FilterSamplePreparation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @filter_sample_preparation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /filter_sample_preparations/1
  # DELETE /filter_sample_preparations/1.xml
  def destroy
    @title = "filter sample preparation"

    @ss = FilterSample.find(:first, :conditions => [ "filter_sample_preparations_id = ?", params[:id]])
    if !@ss.nil?
      flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
      redirect_to :action => "index"
      return
    end

    @filter_sample_preparation = FilterSamplePreparation.find(params[:id])
    @filter_sample_preparation.destroy

    respond_to do |format|
      format.html { redirect_to(filter_sample_preparations_url) }
      format.xml  { head :ok }
    end
  end
end
