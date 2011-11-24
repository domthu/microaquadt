class MicroArrayDatasController < ApplicationController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update]

  # GET /micro_array_datas
  # GET /micro_array_datas.xml
  def index
    @micro_array_datas = MicroArrayData.all
    @title = "List of micro array datas"
    @title = "Micro array data"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @micro_array_datas }
    end
  end

  # GET /micro_array_datas/1
  # GET /micro_array_datas/1.xml
  def show
    @micro_array_data = MicroArrayData.find(params[:id])
    @title = "Micro array data"

    if @micro_array_data.nil?
        redirect_to :action => "index"
    end

    @ma = MicroArray.find(@micro_array_data.microarray_id)
    @pt = Partner.find(@ma.partner_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @micro_array_data }
    end
  end

  # GET /micro_array_datas/new
  # GET /micro_array_datas/new.xml
  def new
    @micro_array_data = MicroArrayData.new
    @title = "Micro array data"

    redirect_to(micro_array_datas_path)
    return ""


    @ma_c = MicroArray.count()
    if @ma_c.nil? or @ma_c == 0
      flash[:error] = "No micro array found! create first some..."
      redirect_to :action => "index"
      return
    end

    @pt = Partner.find(:first, :conditions => [ "user_id = ?", current_user.id])
    if @pt.nil?
      @ma = MicroArray.all()
    else
      @ma = MicroArray.all(:conditions => [ "partner_id = ?", @pt.id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @micro_array_data }
    end
  end

  # GET /micro_array_datas/1/edit
  def edit
    @micro_array_data = MicroArrayData.find(params[:id])
    @title = "Micro array data"
    @ma = MicroArray.find(@micro_array_data.microarray_id)

    redirect_to(micro_array_datas_path)
    return ""
  end

  # POST /micro_array_datas
  # POST /micro_array_datas.xml
  def create
    @micro_array_data = MicroArrayData.new(params[:micro_array_data])
    @title = "Micro array data"

    respond_to do |format|
      if @micro_array_data.save
        format.html { redirect_to(@micro_array_data, :notice => 'MicroArrayData was successfully created.') }
        format.xml  { render :xml => @micro_array_data, :status => :created, :location => @micro_array_data }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @micro_array_data.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /micro_array_datas/1
  # PUT /micro_array_datas/1.xml
  def update
    @micro_array_data = MicroArrayData.find(params[:id])
    @title = "Micro array data"

    respond_to do |format|
      if @micro_array_data.update_attributes(params[:micro_array_data])
        format.html { redirect_to(@micro_array_data, :notice => 'MicroArrayData was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @micro_array_data.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /micro_array_datas/1
  # DELETE /micro_array_datas/1.xml
  def destroy
#    if !signed_in_and_master?
#      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
#      redirect_to water_types_path
#    else

    @micro_array_data = MicroArrayData.find(params[:id])
    @micro_array_data.destroy
    @title = "Micro array data"

    respond_to do |format|
      format.html { redirect_to(micro_array_datas_url) }
      format.xml  { head :ok }
    end
#    end
  end

  private

    def correct_user
      @machild = MicroArrayData.find(params[:id])
      @ma = MicroArray.find(@machild.microarray_id)
      @partner = Partner.find(@ma.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the micro array datas can modify it."
      redirect_to(micro_array_datas_path)
    end

end

