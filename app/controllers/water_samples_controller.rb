class WaterSamplesController < AuthController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:show, :edit, :update]

#http://apidock.com/rails/ActionView/Helpers/FormHelper/form_for
#Routers:
#map.resources :water_sample, :has_one => [:wfilter]
#Views:
#form_for [@water_sample, @wfilter, :url => water_sample_wfilter_url(@water_sample) do |f|
#...
#end

  # GET /water_samples
  # GET /water_samples.xml
  def index
    @water_samples = WaterSample.all
    @title = "List Water samples"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @water_samples }
    end
  end

  # GET /water_samples/1
  # GET /water_samples/1.xml
  def show
    @water_sample = WaterSample.find(params[:id])
    if @water_sample.nil?
        redirect_to :action => "index"
    end
    @title = "Water samples"
    @s = Sampling.find(@water_sample.samplings_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @water_sample }
    end
  end

  # GET /water_samples/new
  # GET /water_samples/new.xml
  def new
    @water_sample = WaterSample.new
    @title = "Water sample"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @water_sample }
    end
  end

  # GET /water_samples/1/edit
  def edit
    #@water_sample = WaterSample.find(params[:id])  --> Yet done in def correct_user
    @title = "Water sample"
    #Cannot change the sample set during creation
    #<%= select :water_sample,:samplings_id,Sampling.find(:all).collect{|p| [p.verbose_me, p.id]}%>
  end

  # POST /water_samples
  # POST /water_samples.xml
  def create
    @water_sample = WaterSample.new(params[:water_sample])
    @title = "Water sample"

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
    #@water_sample = WaterSample.find(params[:id])  --> Yet done in def correct_user
    @title = "Water sample"

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
    @water_sample = WaterSample.find(params[:id])
    @water_sample.destroy
    @title = "Water sample"

    respond_to do |format|
      format.html { redirect_to(water_samples_url) }
      format.xml  { head :ok }
    end
  end


  private

    def correct_user
      @water_sample = WaterSample.find(params[:id])
      @sampling = Sampling.find(@water_sample.samplings_id)
      @partner = Partner.find(@sampling.partner_id)
      @user = User.find(@partner.user_id)
      #uses the current_user? method,
      #which (as with deny_access) we will define in the Sessions helper
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the water sample can modify it."
      redirect_to(water_samples_path)
    end

end

