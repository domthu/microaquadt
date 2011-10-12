class MicroArraysController < ApplicationController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update]

  # GET /micro_arrays
  # GET /micro_arrays.xml
  def index
    @micro_arrays = MicroArray.all
    @title = "List of micro arrays"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @micro_arrays }
    end
  end

  # GET /micro_arrays/1
  # GET /micro_arrays/1.xml
  def show
    @micro_array = MicroArray.find(params[:id])
    @title = "Micro array"

    if @micro_array.nil?
        redirect_to :action => "index"
    end
    @pt = Partner.find(@micro_array.partner_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @micro_array }
    end
  end

  # GET /micro_arrays/new
  # GET /micro_arrays/new.xml
  def new
    @micro_array = MicroArray.new
    @title = "Micro array"

    @partners = Partner.find(:all)
    @pt = Partner.find(:first, :conditions => [ "user_id = ?", current_user.id])
    unless @pt.nil?
      #set the selected item
      @micro_array.partner_id = @pt.id
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @micro_array }
    end
  end

  # GET /micro_arrays/1/edit
  def edit
    @micro_array = MicroArray.find(params[:id])
    @title = "Micro array"
  end

  # POST /micro_arrays
  # POST /micro_arrays.xml
  def create
    @micro_array = MicroArray.new(params[:micro_array])
    @title = "Micro array"

    @valid = false
    if @micro_array.partner.nil?
      flash.now[:error] = "No partner found for this micro array"
      @valid = true
    end

    if @valid
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @micro_array.errors, :status => :unprocessable_entity }
      end
    end

    respond_to do |format|
      if @micro_array.save
        format.html { redirect_to(@micro_array, :notice => 'MicroArray was successfully created.') }
        format.xml  { render :xml => @micro_array, :status => :created, :location => @micro_array }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @micro_array.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /micro_arrays/1
  # PUT /micro_arrays/1.xml
  def update
    @micro_array = MicroArray.find(params[:id])
    @title = "Micro array"

    respond_to do |format|
      if @micro_array.update_attributes(params[:micro_array])
        format.html { redirect_to(@micro_array, :notice => 'MicroArray was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @micro_array.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /micro_arrays/1
  # DELETE /micro_arrays/1.xml
  def destroy
    @micro_array = MicroArray.find(params[:id])
    @micro_array.destroy
    @title = "Micro array"

    respond_to do |format|
      format.html { redirect_to(micro_arrays_url) }
      format.xml  { head :ok }
    end
  end

  private

    def correct_user
      @ma = MicroArray.find(params[:id])
      @partner = Partner.find(@ma.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the micro array can modify it."
      redirect_to(micro_arrays_path)
    end

end

