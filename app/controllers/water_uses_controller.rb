class WaterUsesController < AuthController

  # GET /water_uses
  # GET /water_uses.xml
  def index
    @water_uses = WaterUse.all
    @title = "water uses"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @water_uses }
    end
  end

  # GET /water_uses/1
  # GET /water_uses/1.xml
  def show
    @water_use = WaterUse.find(params[:id])
    @title = "water uses"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @water_use }
    end
  end

  # GET /water_uses/new
  # GET /water_uses/new.xml
  def new
    @water_use = WaterUse.new
    @title = "water use"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @water_use }
    end
  end

  # GET /water_uses/1/edit
  def edit
    @water_use = WaterUse.find(params[:id])
    @title = "water use"
  end

  # POST /water_uses
  # POST /water_uses.xml
  def create
    @water_use = WaterUse.new(params[:water_use])
    @title = "water use"

    respond_to do |format|
      if @water_use.save
        format.html { redirect_to(@water_use, :notice => 'WaterUse was successfully created.') }
        format.xml  { render :xml => @water_use, :status => :created, :location => @water_use }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @water_use.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /water_uses/1
  # PUT /water_uses/1.xml
  def update
    @water_use = WaterUse.find(params[:id])
    @title = "water use"

    respond_to do |format|
      if @water_use.update_attributes(params[:water_use])
        format.html { redirect_to(@water_use, :notice => 'WaterUse was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @water_use.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /water_uses/1
  # DELETE /water_uses/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to water_uses_path
    else

        @water_use = WaterUse.find(params[:id])
        @water_use.destroy
        @title = "water use"

        respond_to do |format|
          format.html { redirect_to(water_uses_url) }
          format.xml  { head :ok }
        end
    end
  end
end

