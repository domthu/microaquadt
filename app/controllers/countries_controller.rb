class CountriesController < AuthController   # < ApplicationController
  # GET /countries
  # GET /countries.xml
  def index
    @countries = Country.all
    @title = "List of countries"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.xml
  def show
    @country = Country.find(params[:id])
    @title = "Country"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @country }
    end
  end

  # GET /countries/new
  # GET /countries/new.xml
  def new
    @country = Country.new
    @title = "Country"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @country }
    end
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
    @title = "Country"
  end

  # POST /countries
  # POST /countries.xml
  def create
    @country = Country.new(params[:country])
    @title = "Country"

    respond_to do |format|
      if @country.save
        format.html { redirect_to(@country, :notice => 'Country was successfully created.') }
        format.xml  { render :xml => @country, :status => :created, :location => @country }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /countries/1
  # PUT /countries/1.xml
  def update
    @country = Country.find(params[:id])
    @title = "Country"

    respond_to do |format|
      if @country.update_attributes(params[:country])
        format.html { redirect_to(@country, :notice => 'Country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to altitude_types_path
    else

        @title = "Country"

        @geo = Geo.find(:first, :conditions => [ "country_id = ?", params[:id]])
        if !@geo.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries (Geo) in the system..."
          redirect_to :action => "index"
          return
        end

        @ss = Partner.find(:first, :conditions => [ "country_id = ?", params[:id]])
        if !@ss.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries (Partner) in the system..."
          redirect_to :action => "index"
          return
        end

        @country = Country.find(params[:id])
        @country.destroy

        respond_to do |format|
          format.html { redirect_to(countries_url) }
          format.xml  { head :ok }
        end
    end
  end
end

