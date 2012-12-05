class SamplingsController < AuthController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update, :delete, :destroy]

  # GET /samplings
  # GET /samplings.xml
  def index
    @samplings = Sampling.all
    @title = "List of samplings"

    #samplings = Sampling.find(:all, :joins=> [:sampling_equipments, :partner, :sampling_site]) do
    samplings = Sampling.find(:all, :joins=> [:partner, :sampling_site]) do
        if params[:_search] == "true"
            volume =~ "%#{params[:volume]}%" if params[:volume].present?
            code =~ "%#{params[:code]}%" if params[:code].present?
            sampling_site.name =~ "%#{params[:site_name]}%" if params[:site_name].present?
            sampling_site.code =~ "%#{params[:site_name]}%" if params[:site_name].present?
            partner.code =~ "%#{params[:partner_name]}%" if params[:partner_name].present?
            #KAPPAO because it done an AND operator between ID and CODE
            #partner.id =~ "%#{params[:partner_name]}%" if params[:partner_name].present?
            sampling_equipment.name =~ "%#{params[:sampling_equipment_name]}%" if params[:sampling_equipment_name].present?
        end
        paginate :page => params[:page], :per_page => params[:rows]      
        if params[:sidx] == "site_name"
            order_by "sampling_sites.name #{params[:sord]}, sampling_sites.code #{params[:sord]}"

        elsif params[:sidx] == "partner_name"
            order_by "partners.code #{params[:sord]}"
        elsif params[:sidx] == "code"
            order_by "samplings.code #{params[:sord]}"
        elsif params[:sidx] == "sampling_equipment_name"
            order_by "sampling_equipments.name #{params[:sord]}"
        else
            order_by "#{params[:sidx]} #{params[:sord]}"
        end
    end

#    <th>Sampling site</th>
#    <th>Volume (lt)</th>
#    <th>Code</th>
#    <th>Partner</th>

    respond_to do |format|
        format.html # index.html.erbs directly,
        #format.xml  { render :xml => @samplings }
        format.json { render :json => samplings.to_jqgrid_json(
            [:id, "act",:code,:site_name,:volume,"partner_name", "sampling_equipment_name","edit"],
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

    @fs = FilterSample.all(:conditions => ['sampling_id = ?', @sampling.id ])

    begin
        #if !@sampling.sampling_equipments_id?
        @se = SamplingEquipment.find(@sampling.sampling_equipments_id)
        if @se.nil?
            @se = SamplingEquipment.first
        end
    rescue Exception => e
        @se = SamplingEquipment.first
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
    @pt = get_partner
    unless @pt.nil?
      #set the selected item
      @sampling.partner_id = @pt.id
    end

    #@codtypes = CodeType.all()
    @codegen = get_code(@pt, nil, nil)

    #used for NESTED Model
    #pre-build another attribute while loading the form
    @wf = Wfilter.all()
    @wf.count().times { @sampling.filter_samples.build }    
#    @wf.each do 
#         3.times { @project.tasks.build }
#    end 
    @attr_index = 1
    
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

    #used for NESTED Model
    @wf = Wfilter.all()
    @fs = FilterSample.all(:conditions => ['sampling_id = ' +@sampling.id.to_s ])

 end

  # POST /samplings
  # POST /samplings.xml
  def create
    @sampling = Sampling.new(params[:sampling])

    #used for NESTED Model
    @wf = Wfilter.all()

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

    @pt = get_partner
    @sampling.code = get_code(@pt, @sampling.samplingDate, nil)

    @title = "Sampling"
    
#    @new_filter = params[:pfilter]
#    unless @new_filter.nil? || @new_filter == 0
#        #create new filter object
#        #@obj_new_filter = Wfilter.new(:name => @new_filter)
#        #@obj_new_filter = Wfilter.create(:name => @new_filter)
#        @obj_new_filter = Wfilter.create(:name => @sampling.code)
#        if @obj_new_filter.save
#          #retrieve filter_id and associate to @sampling
#          sampling.wfilter_id = @obj_new_filter.id
#        end
#    end

    respond_to do |format|
      if @sampling.save

        #Change the child code attribute here because the parent code is yet created
        @fs = FilterSample.count(:all, :conditions => ['sampling_id = ' + @sampling.id.to_s ])
        print ('----Change childs attributes here -------- parent (id-'+@sampling.id.to_s+') code is: '+@sampling.code+'. Childs are -['+@fs.to_s+']-\n' )

        unless @fs.nil? and @fs > 0
            #generate the Microaqua code for all child yet created to this parent
            @fs = FilterSample.all(:conditions => ['sampling_id = ' +@sampling.id.to_s ])
            @fs.each_with_index do |child, index|
                print ('----Change childs Old code: (-%s)\n' , child.code)
                #child.code = child.code[0..11] + ("-F%02d" % (index + 1))
                child.code = @sampling.code + ("-F%02d" % (index + 1))
                print ('----Change childs New code: (-%s)\n' , child.code)
                child.save()
            end 
        end 

        format.html { redirect_to(@sampling, :notice => 'Sampling was successfully created.') }
        format.xml  { render :xml => @sampling, :status => :created, :location => @sampling }
      else

        #@partners = Partner.find(:all)
        @codegen = @sampling.code
        @attr_index = 1
        @pt = get_partner

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

    #used for NESTED Model
    @wf = Wfilter.all()

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

    @title = "Sampling"

    #Load data and ensure that no children data are connected
    #@ws = Sampling.find(:first, :conditions => [ "sampling_site_id = ?", params[:id]])
    #if !@ws.nil?
    #  flash[:error] = "This entry cannot be deleted until used by another entries (Water sample) in the system..."
    #  redirect_to :action => "index"
    #  return
    #end
    # --> Cascading delete all chidren FilterSample 
    # --> has_many :filter_samples, :dependent => :destroy, :class_name => 'FilterSample'

    @sampling = Sampling.find(params[:id])
    flash[:notice] = "Deleted water sample: " + @sampling.verbose_me
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
      #2011 create increment number by registered date
      if pdate.nil?
        #only for generate sample code in the new view (but it is hide)
        pdate = Date.today
      end

      unless pdate.nil?
        #time = Time.new
        #@codegen += time.month.to_s + time.year.to_s
        @codegen += pdate.strftime("%y%m%d")
        @codegen += "-"
      end

#      #3 digit = Sample,  001
#      #@cnt = Sampling.count()
#      @cnt = Sampling.calculate(:count, :all, :conditions => ['partner_id = ' + @pid.to_s ])
#      #@lst = Sampling.last
      #2011 create increment number by registered date and partner
#      @cnt = Sampling.calculate(:count, :all, :conditions => ['partner_id =  ? AND samplingDate >= ? AND samplingDate < ? ',  @pid.to_s, Date.today, 1.day.from_now.to_date ])
#      @cnt = Sampling.calculate(:count, :all, :conditions => ['code LIKE ? ', '%'+@codegen+'%'])
      @cnt_objs = Sampling.all(:select => "DISTINCT code", :conditions => ['code LIKE ? ', '%'+@codegen+'%'], :order => 'code DESC')
      @cnt = 1 
      if not @cnt_objs.nil? 
          @cnt_obj = @cnt_objs[0] 
          if not @cnt_obj.nil? 
             #P03-110129-xx
             if not @cnt_obj.code.nil? 
                @end_str = @cnt_obj.code[11..12]
                if not @end_str.nil? 
                    @end = @end_str.to_i
                    @cnt = @end + 1
                 else 
                    @cnt = '0'
                 end
             else 
                @cnt = '0'
             end
          end
      end

      @codegen += "%02d" % @cnt

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
