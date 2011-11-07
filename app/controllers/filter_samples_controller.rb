class FilterSamplesController < AuthController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update, :delete]

#http://apidock.com/rails/ActionView/Helpers/FormHelper/form_for
#Routers:
#map.resources :filter_sample, :has_one => [:wfilter]
#Views:
#form_for [@filter_sample, @wfilter, :url => filter_sample_wfilter_url(@filter_sample) do |f|
#...
#end

  # GET /filter_samples
  # GET /filter_samples.xml
  def index
    @filter_samples = FilterSample.all
    @title = "List Water samples"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @filter_samples }
    end
  end

  # GET /filter_samples/1
  # GET /filter_samples/1.xml
  def show
    @filter_sample = FilterSample.find(params[:id])
    if @filter_sample.nil?
        redirect_to :action => "index"
    end
    @title = "Water samples"
    @s = Sampling.find(@filter_sample.sampling_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @filter_sample }
    end
  end

  # GET /filter_samples/new
  # GET /filter_samples/new.xml
  def new
    @filter_sample = FilterSample.new
    @title = "Water sample"

    @s_c = Sampling.count()
    if @s_c.nil? or @s_c == 0
      flash[:error] = "No sampling found! create first someone..."
      redirect_to :action => "index"
      return
    end

    @pt = Partner.find(:first, :conditions => [ "user_id = ?", current_user.id])
    if @pt.nil?
      @s = Sampling.all()
    else
      @s = Sampling.all(:conditions => [ "partner_id = ?", @pt.id])
    end
    @sx = @s.first
    if !@sx.nil?
        @codegen = get_code(@sx.id)
    else
      flash[:error] = "No sampling created by you found! create your own first sampling before inserting filter sample..."
      redirect_to :action => "index"
      return
    end 
    @wf = Wfilter.all()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @filter_sample }
    end
  end

  # GET /filter_samples/1/edit
  def edit
    #@filter_sample = FilterSample.find(params[:id])  --> Yet done in def correct_user
    @title = "Water sample"
    @code = @filter_sample.code
    @sampling = Sampling.find(@filter_sample.sampling_id)
    #Cannot change the sample set during creation
    #<%= select :filter_sample,:sampling_id,Sampling.find(:all).collect{|p| [p.verbose_me, p.id]}%>
    @wfilter = Wfilter.find(@filter_sample.wfilter_id)
  end

  # POST /filter_samples
  # POST /filter_samples.xml
  def create
    @filter_sample = FilterSample.new(params[:filter_sample])
    @title = "Water sample"

#    @sx = Sampling.find(@filter_sample.sampling_id)
#    if @sx.nil?
#        puts "===========?????????????????????????????????????????????????=========="
#    else
#        puts "===================================" + @sx.verbose_me
#    end
#    @filter_sample.code = get_code(@sx)
    @filter_sample.code = get_code(@filter_sample.sampling_id)
    @wf = Wfilter.find(@filter_sample.wfilter_id) 
    if !@wf.nil?
        @filter_sample.pore_size = @wf.pore_size  
    else
        @filter_sample.pore_size = 0  
    end 

    respond_to do |format|
      if @filter_sample.save
        format.html { redirect_to(@filter_sample, :notice => 'FilterSample was successfully created.') }
        format.xml  { render :xml => @filter_sample, :status => :created, :location => @filter_sample }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @filter_sample.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /filter_samples/1
  # PUT /filter_samples/1.xml
  def update
    #@filter_sample = FilterSample.find(params[:id])  --> Yet done in def correct_user
    @title = "Water sample"

    respond_to do |format|
      if @filter_sample.update_attributes(params[:filter_sample])
        format.html { redirect_to(@filter_sample, :notice => 'FilterSample was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @filter_sample.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /filter_samples/1
  # DELETE /filter_samples/1.xml
  def destroy
    @filter_sample = FilterSample.find(params[:id])
    @filter_sample.destroy
    @title = "Water sample"

    respond_to do |format|
      format.html { redirect_to(filter_samples_url) }
      format.xml  { head :ok }
    end
  end


  private

    def correct_user
      @filter_sample = FilterSample.find(params[:id])
      @sampling = Sampling.find(@filter_sample.sampling_id)
      @partner = Partner.find(@sampling.partner_id)
      @user = User.find(@partner.user_id)
      #uses the current_user? method,
      #which (as with deny_access) we will define in the Sessions helper
      reroute() unless current_user?(@user)
#      reroute() unless current_user?(@filter_sample.sampling.partner.user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the water sample can modify it."
      redirect_to(filter_samples_path)
    end

    def get_code(psampling)
      @codegen = "???"
      if psampling.nil?
        return @codegen
      end
      psampling_id = psampling.id
      if psampling_id.nil?
        return @codegen
      end

      @pt = Sampling.find(psampling_id)
      if not @pt.nil?
          @codegen = @pt.code
      end      
      @codegen += "-"
    
      #@cnt = FilterSample.calculate(:count, :all, :conditions => ['sampling_id = ' + @pid.to_s ])
      @cnt = FilterSample.count(:conditions => ['sampling_id = ' + psampling_id.to_s ])
      if @cnt.nil? or @cnt == 0
        @cnt = 1
      else
         @cnt += 1
      end
      @codegen += "%03d" % @cnt

      return @codegen
    end


end

