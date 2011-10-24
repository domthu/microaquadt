class SamplingSitesController < AuthController

  # GET /sampling_sites
  # GET /sampling_sites.xml

  #before_filter :find_water_use, :only => [:show, :edit, :update]
  #private def find_water_use
  #  #Model name
  #  @wu = WaterUse.find(params[:water_uses_id])
  #end

  def index
    @sampling_sites = SamplingSite.all
    @title = "Sampling sites"
    #@wu = WaterUse.find(@sampling_site.water_uses_id)
    #@wt = WaterType.find(@sampling_site.water_types_id)
    #@lum = LandUseMapping.find(@sampling_site.land_use_mappings_id)
    #@g = Geo.find(@sampling_site.geos_id)

    sampling_sites = SamplingSite.find(:all) do
    #@sampling_sites do --> Kappao
        if params[:_search] == "true"
            code =~ "%#{params[:code]}%" if params[:code].present?
            name =~ "%#{params[:name]}%" if params[:name].present?

            #undefined local variable or method `country_name' for #<Squirrel::Query::ConditionGroup:0xb6ad5050>
#            country =~ "%#{params[:country]}%" if params[:country].present?
#            water_uses =~ "%#{params[:water_uses]}%" if params[:water_uses].present?        
#            w_use_name =~ "%#{params[:w_use_name]}%" if params[:w_use_name].present?
#            w_type_name =~ "%#{params[:w_type_name]}%" if params[:w_type_name].present?
#            land_name =~ "%#{params[:land_name]}%" if params[:land_name].present?
#            geo_name =~ "%#{params[:geo_name]}%" if params[:geo_name].present?
#            country_name =~ "%#{params[:country_name]}%" if params[:country_name].present?
        end
        paginate :page => params[:page], :per_page => params[:rows]      
        order_by "#{params[:sidx]} #{params[:sord]}"
    end

#    <td><%=h WaterUse.find(sampling_site.water_uses_id).name %></td>
#    <td><%=h WaterType.find(sampling_site.water_types_id).name %></td>
#    <td><%=h LandUseMapping.find(sampling_site.land_use_mappings_id).name %></td>
#    <td><%=h Geo.find(sampling_site.geos_id).name %></td>
#    <td><%=h Country.find(sampling_site.country_id).name %></td>

    respond_to do |format|
        format.html # index.html.erb
        #format.xml  { render :xml => @sampling_sites }     
        # Select Kappao ,"country.name"
        format.json { render :json => sampling_sites.to_jqgrid_json(
            [:id, "act",:code,:name,:w_use_name,:w_type_name,"land_name","geo_name","country_name", "edit"],
            params[:page], params[:rows], sampling_sites.total_entries) }			
    end
  end
#{ :field => "water_uses_id", :label => "Water use", :edittype => "select", :editoptions => { :data => [WaterUse.all, :id, :name] }  },	


#  def post_data
#    if params[:oper] == "del"
#      User.find(params[:id]).destroy
#    else
#      user_params = { :pseudo => params[:pseudo], :firstname => params[:firstname], :lastname => params[:lastname], 
#                      :email => params[:email], :role => params[:role] }
#      if params[:id] == "_empty"
#        User.create(user_params)
#      else
#        User.find(params[:id]).update_attributes(user_params)
#      end
#    end
#    render :nothing => true
#  end

  # GET /sampling_sites/1
  # GET /sampling_sites/1.xml
  def show
    @sampling_site = SamplingSite.find(params[:id])
    if @sampling_site.nil?
        redirect_to :action => "index"
    end
    @title = "Sampling sites"
    @wu = WaterUse.find(@sampling_site.water_uses_id)
    @wt = WaterType.find(@sampling_site.water_types_id)
    @lum = LandUseMapping.find(@sampling_site.land_use_mappings_id)
    @g = Geo.find(@sampling_site.geos_id)

    #  <%=h @sampling_site.country.name %>
    #@Mysql::Error: Unknown column 'countries.sampling_site_id' in 'where clause': SELECT * FROM `countries` WHERE (`countries`.sampling_site_id = 1)  LIMIT 1
    @state = Country.find(@sampling_site.country_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sampling_site }
    end
  end

  # GET /sampling_sites/new
  # GET /sampling_sites/new.xml
  def new
    @sampling_site = SamplingSite.new
    @title = "Sampling site"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sampling_site }
    end
  end

  # GET /sampling_sites/1/edit
  def edit
    @sampling_site = SamplingSite.find(params[:id])
    @title = "Sampling site"
  end

  # POST /sampling_sites
  # POST /sampling_sites.xml
  def create
    @sampling_site = SamplingSite.new(params[:sampling_site])
    @title = "Sampling site"

    respond_to do |format|
      if @sampling_site.save
        format.html { redirect_to(@sampling_site, :notice => 'SamplingSite was successfully created.') }
        format.xml  { render :xml => @sampling_site, :status => :created, :location => @sampling_site }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sampling_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sampling_sites/1
  # PUT /sampling_sites/1.xml
  def update
    @sampling_site = SamplingSite.find(params[:id])
    @title = "Sampling site"

    respond_to do |format|
      if @sampling_site.update_attributes(params[:sampling_site])
        format.html { redirect_to(@sampling_site, :notice => 'SamplingSite was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sampling_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sampling_sites/1
  # DELETE /sampling_sites/1.xml
  def destroy
    @sampling_site = SamplingSite.find(params[:id])
    @sampling_site.destroy
    @title = "Sampling site"

    respond_to do |format|
      format.html { redirect_to(sampling_sites_url) }
      format.xml  { head :ok }
    end
  end
end


#<table>
#  <tr>
#    <th>Code</th>
#    <th>Name</th>
#    <th>Water type</th>
#    <th>Water use</th>
#    <th>Land use</th>
#    <th>Geo</th>
#    <th>Country</th>
#  </tr>

#<% @sampling_sites.each do |sampling_site| %>
#  <tr>
#    <td><%=h sampling_site.code %></td>
#    <td><%=h sampling_site.name %></td>
#    <td><%=h WaterUse.find(sampling_site.water_uses_id).name %></td>
#    <td><%=h WaterType.find(sampling_site.water_types_id).name %></td>
#    <td><%=h LandUseMapping.find(sampling_site.land_use_mappings_id).name %></td>
#    <td><%=h Geo.find(sampling_site.geos_id).name %></td>
#    <td><%=h Country.find(sampling_site.country_id).name %></td>
#    <td><%= link_to 'Show', sampling_site %></td>
#    <td><%= link_to 'Edit', edit_sampling_site_path(sampling_site) %></td>
#    <td><%= link_to 'Delete', sampling_site, :confirm => 'Are you sure?', :method => :delete %></td>
#  </tr>
#<% end %>
#</table>


#<script type="text/javascript">
#function handleSelection(id) {
#	alert('ID selected %>: ' + id);
#}
#</script>
#{ :selection_handler => "handleSelection", :direct_selection => true, :edit => true }

