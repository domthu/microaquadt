class MicroArrayAnalysisFilesController < ApplicationController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update]

  # GET /micro_array_analysis_files
  # GET /micro_array_analysis_files.xml
  def index
    @micro_array_analysis_files = MicroArrayAnalysisFile.all
    @title = "List of micro array analysis files"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @micro_array_analysis_files }
    end
  end

  # GET /micro_array_analysis_files/1
  # GET /micro_array_analysis_files/1.xml
  def show
    @micro_array_analysis_file = MicroArrayAnalysisFile.find(params[:id])
    @title = "Micro array analysis file"

    if @micro_array_analysis_file.nil?
        redirect_to :action => "index"
    end

    @ma = MicroArray.find(@micro_array_analysis_file.microarray_id)
    @pt = Partner.find(@ma.partner_id)


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @micro_array_analysis_file }
    end
  end

  # GET /micro_array_analysis_files/new
  # GET /micro_array_analysis_files/new.xml
  def new
    @micro_array_analysis_file = MicroArrayAnalysisFile.new
    @title = "Micro array analysis file"

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
      format.xml  { render :xml => @micro_array_analysis_file }
    end
  end

  # GET /micro_array_analysis_files/1/edit
  def edit
    @micro_array_analysis_file = MicroArrayAnalysisFile.find(params[:id])
    @title = "Micro array analysis file"
    @ma = MicroArray.find(@micro_array_analysis_file.microarray_id)
  end

  # POST /micro_array_analysis_files
  # POST /micro_array_analysis_files.xml
  def create
    @micro_array_analysis_file = MicroArrayAnalysisFile.new(params[:micro_array_analysis_file])
    @title = "Micro array analysis file"

    respond_to do |format|
      if @micro_array_analysis_file.save
        format.html { redirect_to(@micro_array_analysis_file, :notice => 'MicroArrayAnalysisFile was successfully created.') }
        format.xml  { render :xml => @micro_array_analysis_file, :status => :created, :location => @micro_array_analysis_file }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @micro_array_analysis_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /micro_array_analysis_files/1
  # PUT /micro_array_analysis_files/1.xml
  def update
    @micro_array_analysis_file = MicroArrayAnalysisFile.find(params[:id])
    @title = "Micro array analysis file"

    respond_to do |format|
      if @micro_array_analysis_file.update_attributes(params[:micro_array_analysis_file])
        format.html { redirect_to(@micro_array_analysis_file, :notice => 'MicroArrayAnalysisFile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @micro_array_analysis_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /micro_array_analysis_files/1
  # DELETE /micro_array_analysis_files/1.xml
  def destroy
    @micro_array_analysis_file = MicroArrayAnalysisFile.find(params[:id])
    @micro_array_analysis_file.destroy
    @title = "Micro array analysis file"

    respond_to do |format|
      format.html { redirect_to(micro_array_analysis_files_url) }
      format.xml  { head :ok }
    end
  end

  private

    def correct_user
      @machild = MicroArrayAnalysisFile.find(params[:id])
      @ma = MicroArray.find(@machild.microarray_id)
      @partner = Partner.find(@ma.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the micro array  analysis file can modify it."
      redirect_to(micro_array_analysis_files_path)
    end

end

