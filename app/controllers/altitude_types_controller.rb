class AltitudeTypesController < ApplicationController
  # GET /altitude_types
  # GET /altitude_types.xml
  def index
    @altitude_types = AltitudeType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @altitude_types }
    end
  end

  # GET /altitude_types/1
  # GET /altitude_types/1.xml
  def show
    @altitude_type = AltitudeType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @altitude_type }
    end
  end

  # GET /altitude_types/new
  # GET /altitude_types/new.xml
  def new
    @altitude_type = AltitudeType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @altitude_type }
    end
  end

  # GET /altitude_types/1/edit
  def edit
    @altitude_type = AltitudeType.find(params[:id])
  end

  # POST /altitude_types
  # POST /altitude_types.xml
  def create
    @altitude_type = AltitudeType.new(params[:altitude_type])

    respond_to do |format|
      if @altitude_type.save
        format.html { redirect_to(@altitude_type, :notice => 'AltitudeType was successfully created.') }
        format.xml  { render :xml => @altitude_type, :status => :created, :location => @altitude_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @altitude_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /altitude_types/1
  # PUT /altitude_types/1.xml
  def update
    @altitude_type = AltitudeType.find(params[:id])

    respond_to do |format|
      if @altitude_type.update_attributes(params[:altitude_type])
        format.html { redirect_to(@altitude_type, :notice => 'AltitudeType was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @altitude_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /altitude_types/1
  # DELETE /altitude_types/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to altitude_types_path
    else

        @altitude_type = AltitudeType.find(params[:id])
        @altitude_type.destroy

        respond_to do |format|
          format.html { redirect_to(altitude_types_url) }
          format.xml  { head :ok }
        end
    end
  end
end
