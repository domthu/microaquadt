class MicroArrayImagesController < ApplicationController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update]

  # GET /micro_array_images
  # GET /micro_array_images.xml
  def index
    @micro_array_images = MicroArrayImage.all
    @title = "List of micro array images"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @micro_array_images }
    end
  end

  # GET /micro_array_images/1
  # GET /micro_array_images/1.xml
  def show
    @micro_array_image = MicroArrayImage.find(params[:id])
    @title = "Micro array image"

    if @micro_array_image.nil?
        redirect_to :action => "index"
    end

    @ex = Experiment.find(@micro_array_image.experiment_id)
    @pt = Partner.find(@ex.partner_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @micro_array_image }
    end
  end

  # GET /micro_array_images/new
  # GET /micro_array_images/new.xml
  def new
    @micro_array_image = MicroArrayImage.new
    @title = "Micro array image"


    @ex_c = Experiment.count()
     if @ex_c.nil? or @ex_c == 0
      flash[:error] = "No micro array experiment found! create first some..."
      redirect_to :action => "index"
      return
     end

    @pt = get_partner
     if @pt.nil?
      @ex = Experiment.all()
     else
      @ex = Experiment.all(:conditions => [ "partner_id = ?", @pt.id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @micro_array_image }
    end
  end

  # GET /micro_array_images/1/edit
  def edit
    @micro_array_image = MicroArrayImage.find(params[:id])
    @title = "Micro array image"
    @ex = Experiment.find(@micro_array_image.experiment_id)
  end

  # POST /micro_array_images
  # POST /micro_array_images.xml
  def create
    @micro_array_image = MicroArrayImage.new(params[:micro_array_image])
    @title = "Micro array image"

    respond_to do |format|
      if @micro_array_image.save
        format.html { redirect_to(@micro_array_image, :notice => 'MicroArrayImage was successfully created.') }
        format.xml  { render :xml => @micro_array_image, :status => :created, :location => @micro_array_image }
      else

        @pt = get_partner
         if @pt.nil?
          @ex = Experiment.all()
         else
          @ex = Experiment.all(:conditions => [ "partner_id = ?", @pt.id])
         end

        format.html { render :action => "new" }
        format.xml  { render :xml => @micro_array_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /micro_array_images/1
  # PUT /micro_array_images/1.xml
  def update
    @micro_array_image = MicroArrayImage.find(params[:id])
    @title = "Micro array image"

    respond_to do |format|
      if @micro_array_image.update_attributes(params[:micro_array_image])
        format.html { redirect_to(@micro_array_image, :notice => 'MicroArrayImage was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @micro_array_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /micro_array_images/1
  # DELETE /micro_array_images/1.xml
  def destroy
#    if !signed_in_and_master?
#      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
#      redirect_to water_types_path
#    else

    @title = "Micro array image"

    @micro_array_image = MicroArrayImage.find(params[:id])
    @micro_array_image.destroy

    respond_to do |format|
      format.html { redirect_to(micro_array_images_url) }
      format.xml  { head :ok }
    end
#    end
  end

  private

    def correct_user
      @machild = MicroArrayImage.find(params[:id])
      @ex = Experiment.find(@machild.experiment_id)
      @partner = Partner.find(@ex.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the micro array image can modify it."
      redirect_to(micro_array_images_path)
    end

end

