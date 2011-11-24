class FilterSamplesController < AuthController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update, :delete]
#  before_create :set_foo_to_now  --> Rails 3
#  def set_foo_to_now
#    self.samplingDate = DateTime.now
#  end

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
    @title = "List filter samples"

    if params[:id].present?
        logger.warn("#{Time.now} - filter_sampling filtered by: #{params[:id]}")
        #@filter_samples = FilterSample.all(:conditions => [ "sampling_id = ?", params[:id]])
        #@cond = params[:id]
        filter_samples = FilterSample.find(:all, :conditions => [ "sampling_id = ?", params[:id]]) do
            if params[:_search] == "true"
                code =~ "%#{params[:code_name]}%" if params[:code_name].present?
                barcode =~ "%#{params[:code_name]}%" if params[:code_name].present?
                pore_size >= "%#{params[:filter_name]}%" if params[:filter_name].present?
                volume >= "%#{params[:volume]}%" if params[:volume].present?
                num_filters >= "%#{params[:num_filters]}%" if params[:num_filters].present?
            end
            paginate :page => params[:page], :per_page => params[:rows]      
            order_by "#{params[:sidx]} #{params[:sord]}"
        end
    else
        #@filter_samples = FilterSample.all
        #@cond = "sampling_id"
        filter_samples = FilterSample.find(:all) do
            if params[:_search] == "true"
                code =~ "%#{params[:code_name]}%" if params[:code_name].present?
                barcode =~ "%#{params[:code_name]}%" if params[:code_name].present?
                pore_size >= "%#{params[:filter_name]}%" if params[:filter_name].present?
                volume >= "%#{params[:volume]}%" if params[:volume].present?
                num_filters >= "%#{params[:num_filters]}%" if params[:num_filters].present?
            end
            paginate :page => params[:page], :per_page => params[:rows]      
            order_by "#{params[:sidx]} #{params[:sord]}"
        end
    end
#    filter_samples = FilterSample.find(:all, :conditions => [ "sampling_id = ?", @cond]) do
#    #@filter_samples.each do |filter_samples|  Kappao
#        if params[:_search] == "true"
#            code =~ "%#{params[:code_name]}%" if params[:code_name].present?
#            barcode =~ "%#{params[:code_name]}%" if params[:code_name].present?
#            pore_size >= "%#{params[:filter_name]}%" if params[:filter_name].present?
#            volume >= "%#{params[:volume]}%" if params[:volume].present?
#            num_filters >= "%#{params[:num_filters]}%" if params[:num_filters].present?
#        end
#        paginate :page => params[:page], :per_page => params[:rows]      
#        order_by "#{params[:sidx]} #{params[:sord]}"
#    end

#<th>Sampling</th>
#<th>Code</th>
#<th>Partner</th>
#<th>Filter</th>
#<th>Tube</th>
#<th>Volume</th>
#<th>Barcode</th>

    respond_to do |format|
        format.html # index.html.erb
        #format.xml  { render :xml => @filter_samples }
        format.json { render :json => filter_samples.to_jqgrid_json(
            [:id, "act",:sample_name,"code","barcode","filter_name",:num_filters,:volume,"edit"],
            params[:page], params[:rows], filter_samples.total_entries) }			
    end
  end

  # GET /filter_samples/1
  # GET /filter_samples/1.xml
  def show
    @filter_sample = FilterSample.find(params[:id])
    if @filter_sample.nil?
        redirect_to :action => "index"
    end
    @title = "Filter samples"
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
    @title = "Filter sample"

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
    @title = "Filter sample"
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
    @title = "Filter sample"

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

#    if @filter_sample.samplingDate.nil?
#        @sampling = Sampling.find(@filter_sample.sampling_id)
#        @filter_sample.samplingDate = @sampling.samplingDate  
#    @filter_sample.samplingDate = DateTime.now

    respond_to do |format|
      if @filter_sample.save
        format.html { redirect_to(@filter_sample, :notice => 'FilterSample was successfully created.') }
        format.xml  { render :xml => @filter_sample, :status => :created, :location => @filter_sample }
      else
        @s_c = Sampling.count()
        @pt = Partner.find(:first, :conditions => [ "user_id = ?", current_user.id])
        if @pt.nil?
          @s = Sampling.all()
        else
          @s = Sampling.all(:conditions => [ "partner_id = ?", @pt.id])
        end
        @wf = Wfilter.all()
        format.html { render :action => "new" }
        format.xml  { render :xml => @filter_sample.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /filter_samples/1
  # PUT /filter_samples/1.xml
  def update
    #@filter_sample = FilterSample.find(params[:id])  --> Yet done in def correct_user
    @title = "Filter sample"

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

    @title = "Filter sample"

    @filter_sample = FilterSample.find(params[:id])
    flash[:notice] = "Deleted filter sample: " + @filter_sample.verbose_me
    @filter_sample.destroy

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
      flash[:notice] = "Only the partner who create the Filter sample can modify it."
      redirect_to(filter_samples_path)
    end

    def get_code(psampling_id)
      @codegen = "???"
      if psampling_id.nil?
        return @codegen
      end
#      psampling_id = psampling.id
#      if psampling_id.nil?
#        return @codegen
#      end

      @pt = Sampling.find(psampling_id)
      if not @pt.nil?
          @codegen = @pt.code
      end      
      @codegen += "-"
      @codegen += "F"
    
      #@cnt = FilterSample.calculate(:count, :all, :conditions => ['sampling_id = ' + @pid.to_s ])
      @cnt = FilterSample.count(:conditions => ['sampling_id = ' + psampling_id.to_s ])
      if @cnt.nil? or @cnt == 0
        @cnt = 1
      else
         @cnt += 1 
      end

      #2011 create increment number by registered date
      #@cnt = FilterSample.created_at(Time.now)
      #undefined method `where' for #<Class:0xb6d5ec18>
      #@cnt = FilterSample.where("samplingDate >= :start AND samplingDate < :end",
      #         :start => Date.today,
      #         :end   => 1.day.from_now.to_date)
#      @cnt = FilterSample.count(:conditions => ['samplingDate >= ? AND samplingDate < ? ', Date.today, 2.day.from_now.to_date ]
#      if @cnt.nil? or @cnt == 0
#        @cnt = 1
#      else
#         @cnt += 1 
#      end
      @codegen += "%02d" % @cnt

      return @codegen
    end


end


#INDEX
#<table>
#  <tr>
#    <th>Sampling</th>
#    <th>Code</th>
#    <th>Partner</th>
#    <th>Filter</th>
#    <th>Tube</th>
#    <th>Volume</th>
#    <th>Barcode</th>
#  </tr>
#<% @filter_samples.each do |filter_sample| %>
#  <tr>
#    <td><%=h filter_sample.sampling.verbose_me %></td>
#    <td><%=h filter_sample.code %></td>
#    <td><%=h filter_sample.sampling.partner.verbose_me %></td>
#    <td><%=h filter_sample.wfilter.verbose_me %></td>
#    <td><%=h filter_sample.num_filters %></td>
#    <td><%=h filter_sample.volume %></td>
#    <td><%=h filter_sample.barcode %></td>
#    <% if  auth_sample_user(filter_sample.sampling_id) %>
#      <td><%= link_to 'Show', filter_sample %></td>
#      <td><%= link_to 'Edit', edit_filter_sample_path(filter_sample) or signed_in_and_master? %></td>
#      <td><%= link_to 'Delete', filter_sample, :confirm => 'Are you sure?', :method => :delete %></td>
#    <% end %>
#  </tr>
#<% end %>
#</table>

