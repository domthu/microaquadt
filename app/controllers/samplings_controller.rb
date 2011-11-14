class SamplingsController < AuthController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update, :delete]

  # GET /samplings
  # GET /samplings.xml
  def index
    @samplings = Sampling.all
    @title = "List of samplings"

    samplings = Sampling.find(:all) do
        if params[:_search] == "true"
            volume >= "%#{params[:volume]}%" if params[:volume].present?
            code =~ "%#{params[:code]}%" if params[:code].present?
        end
        paginate :page => params[:page], :per_page => params[:rows]      
        order_by "#{params[:sidx]} #{params[:sord]}"
    end

#    <th>Sampling site</th>
#    <th>Volume (lt)</th>
#    <th>Code</th>
#    <th>Partner</th>

    respond_to do |format|
        format.html # index.html.erbs directly,
        #format.xml  { render :xml => @samplings }
        format.json { render :json => samplings.to_jqgrid_json(
            [:id, "act",:site_name,:volume,:code,"partner_name","edit"],
            params[:page], params[:rows], samplings.total_entries) }			
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
    if @ss.nil?
      flash.now[:error] = "No sampling sites found! create some..."
      redirect_to :action => "index"
    end

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
    #<div class="field cod">
    #  <%= f.label :selected_type, "Code type" %><br />
    #  <%= select (:selected_type, :code, @codtypes.map {|u| [u.verbose_me,u.code]}) %>
    #</div>

    @partners = Partner.find(:all)
    @pt = Partner.find(:first, :conditions => [ "user_id = ?", current_user.id])
    unless @pt.nil?
      #set the selected item
      @sampling.partner_id = @pt.id
    end
    #@sampling.partner_id = 3
    #@sampling.sampling_site_id = 4

    @codtypes = CodeType.all()
    @codegen = get_code(@pt, nil, nil)

    @ss_c = SamplingSite.count()
    if @ss_c.nil? or @ss_c == 0
      flash[:error] = "No sampling sites found! create first someone..."
      redirect_to :action => "index"
      return
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sampling }
    end
  end

  # GET /samplings/1/edit
  def edit
    #@sampling = Sampling.find(params[:id])  --> Yet done in def correct_user
    @title = "Sampling"
    @code = @sampling.code
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
    @valid = false
    if @sampling.sampling_site.nil?
      flash.now[:error] = "No sampling site set for this sampling"
      @valid = true
    end
    if @sampling.partner.nil?
      flash.now[:error] = "No partner found for this sampling"
      @valid = true
    end

    if @valid
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @sampling.errors, :status => :unprocessable_entity }
      end
    end

    @pt = Partner.find(:first, :conditions => [ "user_id = ?", current_user.id])
    #@new_type = params[:selected_type][:code]
    #    <%= select ("selected_type", "code", @codtypes.map {|u| [u.verbose_me,u.code]}) %>
    #@new_type = CodeType.first
    #@sampling.code = get_code(@pt, @sampling.samplingDate,  @new_type.code)
    @sampling.code = get_code(@pt, @sampling.samplingDate, nil)
    #@sampling.code += @sampling.samplingDate.strftime("%y%m%d")
    #@sampling.code += @new_type.to_s

    @title = "Sampling"
    @new_filter = params[:pfilter]
    unless @new_filter.nil? || @new_filter == 0
        #create new filter object
        #@obj_new_filter = Wfilter.new(:name => @new_filter)
        #@obj_new_filter = Wfilter.create(:name => @new_filter)
        @obj_new_filter = Wfilter.create(:name => @sampling.code)
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
#    if !signed_in_and_master?
#      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
#      redirect_to samplings_path
#    else

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
      reroute() unless current_user?(@user) or signed_in_and_master?
    end

    def reroute()
      flash[:notice] = "Only the partner who create the sampling can modify it."
      redirect_to(samplings_path)
    end

    def get_code(partner, pdate, ptype)
      @codegen = ""
      if partner.nil? and not signed_in_and_master?
        return "P??"
      end
      @pid = 1
      unless partner.nil?
        @pid = partner.id
        #2 digits = Nation IT
        #@codegen += partner.country.code.upcase
        #3 or 2 digits -= Partner number, P5 OR P
        @codegen += "P"
        @codegen += "%02d" % partner.fp7_Number
        @codegen += "-"
      else
        if signed_in_and_master?
          @codegen += "ADM"
        else
          @codegen += "P??"
        end
      end

      #4 or 3 = date month and years 1211 OR 121
      unless pdate.nil?
        #time = Time.new
        #@codegen += time.month.to_s + time.year.to_s
        @codegen += pdate.strftime("%y%m%d")
        @codegen += "-"
      end

      #3 digit = Sample,  001
      #@codtypes = CodeType.all()
      #@cnt = Sampling.count()
      @cnt = Sampling.calculate(:count, :all, :conditions => ['partner_id = ' + @pid.to_s ])
      #@codegen += "(" + @pid.to_s + "/" + @cnt.to_s + ")"
      #, :joins => ['last_name != ?', 'Drake']
      if @cnt.nil? or @cnt == 0
        @cnt = 1
      else
        #@lst = Sampling.last
        #@codegen += "%03d" % (@lst.id + 1)
        @cnt += 1
      end
      @codegen += "%03d" % @cnt

      # 1 digit organisms b (bacteria) (PTR5)
      # or 1 digit (PTR4) water tyrpe R (river) Lake etc..
      unless ptype.nil?
        @codegen += ptype.to_s
#      else
#        @codegen += "?"
      end

      return @codegen
    end

end


#INDEX
#<table>
#  <tr>
#    <th>Sampling site</th>
#    <th>Volume (lt)</th>
#    <th>Code</th>
#    <th>Partner</th>
#  </tr>
#<% @samplings.each do |sampling| %>
#  <tr>
#    <td><%=h SamplingSite.find(sampling.sampling_site_id).verbose_me %></td>
#    <td><%=h sampling.volume %></td>
#    <td><%=h sampling.code %></td>
#    <td><%=h Partner.find(sampling.partner_id).verbose_me %></td>
#    <td><%= link_to 'Show', sampling %></td>
#    <% if auth_user(sampling.partner_id) or signed_in_and_master? %>
#      <td><%= link_to 'Edit', edit_sampling_path(sampling) %></td>
#      <td><%= link_to 'Delete', sampling, :confirm => 'Are you sure?', :method => :delete %></td>
#    <% end %>
#  </tr>
#<% end %>
#</table>
