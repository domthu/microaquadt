class GeosController < AuthController

  # GET /geos
  # GET /geos.xml
  def index
    @geos = Geo.all
    @title = "Geographical positions"

    @map = GMap.new("map_div_id")
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init([46.95, 7.416667], 4) #Berne Suisse
     
    for g in @geo
        marker = GMarker.new([g.lat,  g.lon],
          :title => g.name, :info_window => g.verbose_me)
        @map.overlay_init(marker)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @geos }
    end
  end

  # GET /geos/1
  # GET /geos/1.xml
  def show
    @geo = Geo.find(params[:id])
    @title = "Geographical positions"

    @map = GMap.new("map_div_id")
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init([@geo.lat,  @geo.lon], 4)
     
    marker = GMarker.new([@geo.lat,  @geo.lon],
      :title => @geo.name, :info_window => @geo.verbose_me)
    @map.overlay_init(marker)

#    #  <%=h @geo.country.name %>
#    #@Mysql::Error: Unknown column 'countries.geo_id' in 'where clause': SELECT * FROM `countries` WHERE (`countries`.sampling_site_id = 1)  LIMIT 1
    @state = Country.find(@geo.country_id)


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @geo }
    end
  end

  # GET /geos/new
  # GET /geos/new.xml
  def new
    @geo = Geo.new
    @title = "Geographical position"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @geo }
    end
  end

  # GET /geos/1/edit
  def edit
    @geo = Geo.find(params[:id])
    @title = "Geographical position"
  end

  # POST /geos
  # POST /geos.xml
  def create
    @geo = Geo.new(params[:geo])
    @title = "Geographical position"

    respond_to do |format|
      if @geo.save
        format.html { redirect_to(@geo, :notice => 'Geo was successfully created.') }
        format.xml  { render :xml => @geo, :status => :created, :location => @geo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @geo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /geos/1
  # PUT /geos/1.xml
  def update
    @geo = Geo.find(params[:id])
    @title = "Geographical position"

    respond_to do |format|
      if @geo.update_attributes(params[:geo])
        format.html { redirect_to(@geo, :notice => 'Geo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @geo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /geos/1
  # DELETE /geos/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to geos_path
    else

        @geo = Geo.find(params[:id])
        @geo.destroy
        @title = "Geographical position"

        respond_to do |format|
          format.html { redirect_to(geos_url) }
          format.xml  { head :ok }
        end
    end
  end
end

