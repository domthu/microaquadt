class MicroArrayValidationsController < ApplicationController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update]

  # GET /micro_array_validations
  # GET /micro_array_validations.xml
  def index
    @micro_array_validations = MicroArrayValidation.all
    @title = "List of micro array validations"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @micro_array_validations }
    end
  end

  # GET /micro_array_validations/1
  # GET /micro_array_validations/1.xml
  def show
    @micro_array_validation = MicroArrayValidation.find(params[:id])
    @title = "Micro array validation"

    if @micro_array_validation.nil?
        redirect_to :action => "index"
    end

    @ma = MicroArray.find(@micro_array_validation.microarray_id)
    @pt = Partner.find(@ma.partner_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @micro_array_validation }
    end
  end

  # GET /micro_array_validations/new
  # GET /micro_array_validations/new.xml
  def new
    @micro_array_validation = MicroArrayValidation.new
    @title = "Micro array validation"

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
      format.xml  { render :xml => @micro_array_validation }
    end
  end

  # GET /micro_array_validations/1/edit
  def edit
    @micro_array_validation = MicroArrayValidation.find(params[:id])
    @title = "Micro array validation"
    @ma = MicroArray.find(@micro_array_validation.microarray_id)
  end

  # POST /micro_array_validations
  # POST /micro_array_validations.xml
  def create
    @micro_array_validation = MicroArrayValidation.new(params[:micro_array_validation])
    @title = "Micro array validation"

    respond_to do |format|
      if @micro_array_validation.save
        format.html { redirect_to(@micro_array_validation, :notice => 'MicroArrayValidation was successfully created.') }
        format.xml  { render :xml => @micro_array_validation, :status => :created, :location => @micro_array_validation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @micro_array_validation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /micro_array_validations/1
  # PUT /micro_array_validations/1.xml
  def update
    @micro_array_validation = MicroArrayValidation.find(params[:id])
    @title = "Micro array validation"

    respond_to do |format|
      if @micro_array_validation.update_attributes(params[:micro_array_validation])
        format.html { redirect_to(@micro_array_validation, :notice => 'MicroArrayValidation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @micro_array_validation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /micro_array_validations/1
  # DELETE /micro_array_validations/1.xml
  def destroy
    @micro_array_validation = MicroArrayValidation.find(params[:id])
    @micro_array_validation.destroy
    @title = "Micro array validation"

    respond_to do |format|
      format.html { redirect_to(micro_array_validations_url) }
      format.xml  { head :ok }
    end
  end

  private

    def correct_user
      @machild = MicroArrayValidation.find(params[:id])
      @ma = MicroArray.find(@machild.microarray_id)
      @partner = Partner.find(@ma.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the micro array validation can modify it."
      redirect_to(micro_array_validations_path)
    end

end

