class SamplingEquipmentsController < AuthController

  layout 'application'

  # GET /sampling_equipments
  # GET /sampling_equipments.xml
  def index
    @title = "sampling equipments"
    @sampling_equipments = SamplingEquipment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sampling_equipments }
    end
  end

  # GET /sampling_equipments/1
  # GET /sampling_equipments/1.xml
  def show
    @title = "sampling equipment"
    @sampling_equipment = SamplingEquipment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sampling_equipment }
    end
  end

  # GET /sampling_equipments/new
  # GET /sampling_equipments/new.xml
  def new
    @title = "sampling equipment"
    @sampling_equipment = SamplingEquipment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sampling_equipment }
    end
  end

  # GET /sampling_equipments/1/edit
  def edit
    @title = "sampling equipment"
    @sampling_equipment = SamplingEquipment.find(params[:id])
  end

  # POST /sampling_equipments
  # POST /sampling_equipments.xml
  def create
    @title = "sampling equipment"
    @sampling_equipment = SamplingEquipment.new(params[:sampling_equipment])

    respond_to do |format|
      if @sampling_equipment.save
        format.html { redirect_to(@sampling_equipment, :notice => 'SamplingEquipment was successfully created.') }
        format.xml  { render :xml => @sampling_equipment, :status => :created, :location => @sampling_equipment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sampling_equipment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sampling_equipments/1
  # PUT /sampling_equipments/1.xml
  def update
    @title = "sampling equipment"
    @sampling_equipment = SamplingEquipment.find(params[:id])

    respond_to do |format|
      if @sampling_equipment.update_attributes(params[:sampling_equipment])
        format.html { redirect_to(@sampling_equipment, :notice => 'SamplingEquipment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sampling_equipment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sampling_equipments/1
  # DELETE /sampling_equipments/1.xml
  def destroy
    @title = "sampling equipment"

    @ss = Sampling.find(:first, :conditions => [ "sampling_equipments_id = ?", params[:id]])
    if !@ss.nil?
      flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
      redirect_to :action => "index"
      return
    end

    @sampling_equipment = SamplingEquipment.find(params[:id])
    @sampling_equipment.destroy

    respond_to do |format|
      format.html { redirect_to(sampling_equipments_url) }
      format.xml  { head :ok }
    end
  end
end
