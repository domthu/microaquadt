class MicroArrayImagesController < ApplicationController

  include SessionsHelper

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update]

  # GET /micro_array_images
  # GET /micro_array_images.xml
  def index

    #@micro_array_images = MicroArrayImage.all
    @title = "List of micro array images"

    micro_array_images = MicroArrayImage.find(:all, :joins=>[:partner]) do
        #if params[:_search] == "true"

       # end
        paginate :page => params[:page], :per_page => params[:rows]      
     
     end

    respond_to do |format|
        format.html # index.html.erbs directly,
        #format.xml  { render :xml => @samplings }
        format.json { render :json => micro_array_images.to_jqgrid_json([:id,"act","image_code",:name,:II_ImageID,:II_Channel,:II_Status,"image_date","edit"], params[:page], params[:rows], micro_array_images.total_entries) }			
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

    @pt = get_partner
    #@ex_c = Experiment.count()
     #if @ex_c.nil? or @ex_c == 0
      #flash[:error] = "No micro array experiment found! create first some..."
      #redirect_to :action => "index"
      #return
     #end

    #@pt = get_partner
     #if @pt.nil?
     # @ex = Experiment.all()
     #else
     # @ex = Experiment.all(:conditions => [ "partner_id = ?", @pt.id])
    #end

    3.times {@micro_array_image.image_assets.build}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @micro_array_image }
    end
  end

  # GET /micro_array_images/1/edit
  def edit
    @micro_array_image = MicroArrayImage.find(params[:id])
    @title = "Micro array image"

    3.times {@micro_array_image.image_assets.build}
    
  end

  # POST /micro_array_images
  # POST /micro_array_images.xml
  def create
    @micro_array_image = MicroArrayImage.new(params[:micro_array_image])
    @title = "Micro array image"

    @valid = false

   # if @experiment.partner.nil?
    #   flash.now[:error] = "No Partner found for the Image files upload"
     #  @valid = true
    #end

    #if @valid
     # respond_to do |format|
	#      format.html { render :action => "new" }
	 #     format.xml  { render :xml => @micro_array_image.errors, :status => :unprocessable_entity }
         # end
      # return
    #end

    #@savedfile = false

    
    @pt = get_partner
    @micro_array_image.icode = get_code(@pt, @micro_array_image.created_at, nil)

    #begin
    #
    #     uploaded_io = params[:micro_array_image][:image]
#
 #        if uploaded_io.to_s == "" 
#		  flash.now[:notice] = "File not selected. Empty..."
#		  logger.debug "microarray image create: dowload image file empty"
 #        else
  #          name =  Time.now.strftime("%Y%m%d%H%M%S ") + sanitize_filename(uploaded_io.original_filename)
   #         logger.debug "File uploaded original name: " + name + ", type: " + uploaded_io.content_type 
    #        directory = "public/photos/"  
     #       Dir.mkdir(directory) unless File.directory?(directory)
      #      #path = File.join(directory, name)
  #          #File.open(path, "wb") { |file| file.write(uploaded_io.read) }                                   
  #          @micro_array_image.image_title = name 
  #          @micro_array_image.image_file_title = directory
  #          @savedFile = true
  #       end 
#
 #       if @savedFile == false
 #         respond_to do |format|
 #           flash.now[:error] = "Error loading File"
 #           format.html { render :action => "new" }
 #           format.xml  { render :xml => @micro_array_image.errors, :status => :unprocessable_entity }
 #         end
 #         return
 #       end
#
 #   rescue => err
 #     
 #     flash.now[:error] = "Exception: #{err}..."
 #     #print to the console
 #     puts "Exception: #{err}"
 #     logger.error "microarray image file: " + err.message  
 #     logger.error err.backtrace.inspect
#
#    end


   respond_to do |format|

         # @savedfile and
       if @micro_array_image.save

        format.html { redirect_to(@micro_array_image, :notice => 'Micro array image was successfully created.') }
        format.xml  { render :xml => @micro_array_image, :status => :created, :location => @micro_array_image }
       else

        @pt = get_partner
        # if @pt.nil?
         # @ex = Experiment.all()
         #else
         # @ex = Experiment.all(:conditions => [ "partner_id = ?", @pt.id])
         #end

        format.html { render :action => "new" }
        format.xml  { render :xml => @micro_array_image.errors, :status => :unprocessable_entity }
      end
    end
  end


  #def sanitize_filename(file_name)
    # get only the filename, not the whole path (from IE)
   # just_filename = File.basename(file_name) 
    # replace all none alphanumeric, underscore or perioids
    # with underscore
    #return just_filename.sub(/[^\w\.\-]/,'_') 
  #end


  # PUT /micro_array_images/1
  # PUT /micro_array_images/1.xml
  def update
    @micro_array_image = MicroArrayImage.find(params[:id])
    @title = "Micro array image"


    respond_to do |format|
      if @micro_array_image.update_attributes(params[:micro_array_image])
        format.html { redirect_to(@micro_array_image, :notice => 'MicroArrayImage profile was saved successfully.') }
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
    flash[:notice] = "Deleted Microarray image: " + @micro_array_image.verbose_me
    @micro_array_image.destroy

    respond_to do |format|
      format.html { redirect_to micro_array_images_path }
      format.xml  { head :ok }
    end
#    end
  end

  private

    def correct_user
      @machild = MicroArrayImage.find(params[:id])
      @partner = Partner.find(@machild.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the micro array image can modify it."
      redirect_to(micro_array_images_path)
    end

    def get_code(partner, pdate, ptype)
      @codegen = ""
      if partner.nil? and not signed_in_and_master?
        return "image??"
      end
      @pid = 1
      unless partner.nil?
        @pid = partner.id
        #2 digits = Nation IT
        #@codegen += partner.country.code.upcase
        #3 or 2 digits -= Partner number, P5 OR P
        @codegen += "Image"
        @codegen += "-"
        @codegen += "%02d" % partner.fp7_Number
        @codegen += "-"
      else
        if signed_in_and_master?
          @codegen += "ADM"
        else
          @codegen += "Image??"
        end
      end

      #4 or 3 = date month and years 1211 OR 121
      #2011 create increment number by registered date
      if pdate.nil?
        #only for generate image code in the new view (but it is hide)
        pdate = Date.today
      end

      unless pdate.nil?
        #time = Time.new
        #@codegen += time.month.to_s + time.year.to_s
        @codegen += pdate.strftime("%y%m%d")
        @codegen += "-"
      end

      @cnt_objs = MicroArrayImage.all(:select => "DISTINCT icode", :conditions => ['icode LIKE ? ', '%'+@codegen+'%'], :order => 'icode DESC')
      @cnt = 1 
      if not @cnt_objs.nil? 
          @cnt_obj = @cnt_objs[0] 
          if not @cnt_obj.nil? 
             #P03-110129-xx
             if not @cnt_obj.icode.nil? 
                @end_str = @cnt_obj.icode[11..12]
                if not @end_str.nil? 
                    @end = @end_str.to_i
                    @cnt = @end + 1
                 else 
                    @cnt = '0'
                 end
             else 
                @cnt = '0'
             end
          end
      end

      @codegen += "%02d" % @cnt

      # 1 digit organisms b (bacteria) (PTR5)
      # or 1 digit (PTR4) water tyrpe R (river) Lake etc..
      unless ptype.nil?
        @codegen += ptype.to_s
#      else
#        @codegen += "?"
      end

      return @codegen
    end


end

