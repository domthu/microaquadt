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

#<Squirrel::Query::ConditionGroup:0xb6ad5050>
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

    @map = GMap.new("map_div_id")
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init([46.95, 7.416667], 4) #Berne Suisse
     
    for ss in @sampling_sites
        g = ss.geo
        g = Geo.find(ss.geos_id) #undefined method `lat' for nil:NilClass
        marker = GMarker.new([g.lat,  g.lon],
          :title => g.name, :info_window => g.verbose_me)
        @map.overlay_init(marker)
    end

    respond_to do |format|
        format.html # index.html.erb
        #format.xml  { render :xml => @sampling_sites }     
        format.json { render :json => sampling_sites.to_jqgrid_json(
            [:id, "act",:code,:name,:w_use_name,:w_type_name,"land_name","geo_name","edit"],
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
    @geo = Geo.find(@sampling_site.geos_id)

    @at = AltitudeType.find(@sampling_site.altitude_types_id)
    @ca = CatchmentArea.find(@sampling_site.catchment_areas_id)
    @geol = Geology.find(@sampling_site.geologies_id)
    @depth = Depth.find(@sampling_site.depth_id)
    @st = SizeTypology.find(@sampling_site.size_typologies_id)

    @map = GMap.new("map_div_id")
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init([@geo.lat,  @geo.lon], 4)
     
    marker = GMarker.new([@geo.lat,  @geo.lon],
      :title => @geo.name, :info_window => @geo.verbose_me)
    @map.overlay_init(marker)

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
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to sampling_sites_path
    else

        @title = "Sampling site"

        @ws = Sampling.find(:first, :conditions => [ "sampling_site_id = ?", params[:id]])
        if !@ws.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries (Water sample) in the system..."
          redirect_to :action => "index"
          return
        end

        @sampling_site = SamplingSite.find(params[:id])
        flash[:notice] = "Deleted sampling site: " + @sampling_site.verbose_me
        @sampling_site.destroy

        respond_to do |format|
          format.html { redirect_to(sampling_sites_url) }
          format.xml  { head :ok }
        end
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
#  </tr>

#<% @sampling_sites.each do |sampling_site| %>
#  <tr>
#    <td><%=h sampling_site.code %></td>
#    <td><%=h sampling_site.name %></td>
#    <td><%=h WaterUse.find(sampling_site.water_uses_id).name %></td>
#    <td><%=h WaterType.find(sampling_site.water_types_id).name %></td>
#    <td><%=h LandUseMapping.find(sampling_site.land_use_mappings_id).name %></td>
#    <td><%=h Geo.find(sampling_site.geos_id).name %></td>
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




