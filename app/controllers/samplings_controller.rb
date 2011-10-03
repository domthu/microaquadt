class SamplingsController < AuthController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update]

  # GET /samplings
  # GET /samplings.xml
  def index
    @samplings = Sampling.all
    @title = "List of samplings"

    respond_to do |format|
      format.html # index.html.erbs directly,
      format.xml  { render :xml => @samplings }
    end
  end

  # GET /samplings/1
  # GET /samplings/1.xml
  def show
    @sampling = Sampling.find(params[:id])
    @title = "Sampling"

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
    @title = "Sampling"

    #Popolate dropdownlist
    #select(object, method, choices, options = {}, html_options = {})
    #    <%= select :sampling, :partner_id, Partner.find(:all).collect{|p| [p.fp7_Number.to_s + " " + p.name, p.id]}%>
    #collection_select(object, method, collection, value_method, text_method, options = {}, html_options = {})
    #Defined in ActionView::Helpers::FormOptionsHelper
    @partners = Partner.find(:all)
    @pt = Partner.find(:first, :conditions => [ "user_id = ?", current_user.id])
    unless @pt.nil?
      #set the selected item
      @sampling.partner_id = @pt.id
    end
    #@sampling.partner_id = 3
    #@sampling.sampling_site_id = 4

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sampling }
    end
  end

  # GET /samplings/1/edit
  def edit
    #@sampling = Sampling.find(params[:id])  --> Yet done in def correct_user
    @title = "Sampling"
    #Cannot change the sample site set during creation
    #<%= select :sampling,:sampling_site_id,SamplingSite.find(:all).collect{|p| [p.code + " " + p.name, p.id]}%>
    #@ss = SamplingSite.find(params[:id])  --> Yet done in def correct_user
    #Cannot change the partner
    #<%= select :sampling, :partner_id,Partner.find(:all).collect{|p| [p.name, p.id]}%>
 end

  # POST /samplings
  # POST /samplings.xml
  def create
    @sampling = Sampling.new(params[:sampling])
    @title = "Sampling"
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
    #@sampling = Sampling.find(params[:id])  --> Yet done in def correct_user
    @title = "Sampling"
    #@is_Auth = is_current_user(@sampling.partner_id)  --> Yet done in def correct_user

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
    #if !signed_in_and_master?
    #  flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
    #  redirect_to samplings_path
    #else

    #Load data and ensure that no children data are connected
    # --> Todo Foreign Key
    @sampling = Sampling.find(params[:id])
    @title = "Sampling"
    @sampling.destroy

    respond_to do |format|
      format.html { redirect_to(samplings_url) }
      format.xml  { head :ok }
    end

    #end
  end

  private

    def correct_user
      @sampling = Sampling.find(params[:id])
      @ss = SamplingSite.find(@sampling.sampling_site_id)
      @partner = Partner.find(@sampling.partner_id)
      @user = User.find(@partner.user_id)
      #uses the current_user? method,
      #which (as with deny_access) we will define in the Sessions helper
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the sampling can modify it."
      redirect_to(samplings_path)
    end

end

