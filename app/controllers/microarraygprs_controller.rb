class MicroarraygprsController < ApplicationController


  class UnknownTypeError < StandardError
  end

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update] #, :download_csv]
  after_filter :extractFile, :only => [:create]

  # GET /microarraygprs
  # GET /microarraygprs.xml
  def index
    @microarraygprs = Microarraygpr.all
    @title = "List of microarrays GPR files"

    microarraygprs = Microarraygpr.find(:all, :joins=>[:partner]) do
        #if params[:_search] == "true"

       # end
        paginate :page => params[:page], :per_page => params[:rows]      
     
     end

    respond_to do |format|
        format.html # index.html.erbs directly,
        
 format.json { render :json => microarraygprs.to_jqgrid_json([:id,"act","gpr_code","partner_name","title","bcode","gpr_upload_date","edit"], params[:page], params[:rows], microarraygprs.total_entries) }			
    end
  end

  # GET /microarraygprs/1
  # GET /microarraygprs/1.xml
  def show
    @microarraygpr = Microarraygpr.find(params[:id])
    @title = "Microarraygpr"

    if @microarraygpr.nil?
        redirect_to :action => "index"
    end
    @pt = Partner.find(@microarraygpr.partner_id)


    #DOWLOAD FILE FROM SERVER TO CLIENT
    # attachment_fu
    # http://guides.rubyonrails.org/security.html#executable-code-in-file-uploads
    # The send_file() method sends files from the server to the client

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @microarraygpr }
      format.csv { download_csv }
    end
  end

  # GET /microarraygprs/new
  # GET /microarraygprs/new.xml
  def new
    
  logger.debug "::::::::::::::::::::microarray gpr create new (" + current_user.name + "):::::::::::::::::::: "	
    @microarraygpr = Microarraygpr.new
    @title = "Microarray GPR files"

    @partners = Partner.find(:all)
    @pt = get_partner
    unless @pt.nil?
      #set the selected item
      @microarraygpr.partner_id = @pt.id
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @microarraygpr }
    end

  end

  # GET /microarraygprs/1/edit
  def edit
    @microarraygpr = Microarraygpr.find(params[:id])
    @title = "Microarraygpr"
  end

  # POST /microarraygprs
  # POST /microarraygprs.xml
  def create
    logger.debug "::::::::::::::::::::micro array create action (" + current_user.name + "):::::::::::::::::::: "
    @microarraygpr = Microarraygpr.new(params[:microarraygpr])
    @title = "Microarraygpr"

    @valid = false
    if @microarraygpr.partner.nil?
      flash.now[:error] = "No partner found for this microarraygpr"
      @valid = true
    end

    if @valid
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @microarraygpr.errors, :status => :unprocessable_entity }
      end
      return 
    end

    @savedFile = false
    #READ FILE
    #forms rendered using form_for @microarraygpr have their encoding set to multipart/form-data automatically
    begin
        uploaded_io = params[:microarraygpr][:gpr_file]
        
        if uploaded_io.to_s == "" 
          flash.now[:notice] = "File not selected. Empty..."
          logger.debug "Microarraygpr create: dowload file empty"  
        else
            name =  Time.now.strftime("%Y%m%d%H%M%S ") + sanitize_filename(uploaded_io.original_filename)
            logger.debug "File uploaded original name: " + name + ", type: " + uploaded_io.content_type 
            directory = "public/Microarraygprs/"  
            Dir.mkdir(directory) unless File.directory?(directory)
            path = File.join(directory, name)
            File.open(path, "wb") { |file| file.write(uploaded_io.read) }                                   
            @microarraygpr.gpr_title = name 
            @microarraygpr.gpr_file_title = directory
            @savedFile = true
        end
 
        if @savedFile == false
          respond_to do |format|
            flash.now[:error] = "Error loading File"
            format.html { render :action => "new" }
            format.xml  { render :xml => @microarraygpr.errors, :status => :unprocessable_entity }
          end
          return
        end

    #rescue Exception => err  
    rescue => err
      flash.now[:error] = "Exception: #{err}..."
      #print to the console
      puts "Exception: #{err}"
      logger.error "Microarraygpr dowload file: " + err.message  
      logger.error err.backtrace.inspect
    end

    respond_to do |format|
      if @savedFile and @microarraygpr.save
        #SavedFile now Extract Data
        self.extractFile
        self.parse_header
        self.parse_gpr_data
        format.html { 
		flash[:notice] = 'Microarray .GPR file is successfully saved. Associate your GAL & GPR record with the new Microarray Experiment below....!'
		redirect_to :controller => "experiments", :action => "new" }
        format.xml  { render :xml => @microarraygpr, :status => :created, :location => @microarraygpr }
      else

        @partners = Partner.find(:all)
        @pt = get_partner
        unless @pt.nil?
          #set the selected item
          @microarraygpr.partner_id = @pt.id
        end

        format.html { render :action => "new" }
        format.xml  { render :xml => @microarraygpr.errors, :status => :unprocessable_entity }
      end
    end
  end

  def sanitize_filename(file_name)
    # get only the filename, not the whole path (from IE)
    just_filename = File.basename(file_name) 
    # replace all none alphanumeric, underscore or perioids
    # with underscore
    return just_filename.sub(/[^\w\.\-]/,'_') 
  end

 

  #def extractFile(@microarraygpr)
  def extractFile
    begin
      logger.debug "::::::::::::::::::::micro array extract data (" + current_user.name + "):::::::::::::::::::: "
      if @microarraygpr.id.to_s == "" 
        logger.debug "Microarraygpr not saved on database. Extraction routine aborted"  
        return false
      end
      logger.debug "micro array extract data for id " + @microarraygpr.id.to_s
 
      if @microarraygpr.gpr_file_title == "" or @microarraygpr.gpr_title == ""
        logger.debug "Microarraygpr file not found. Extraction routine aborted " + @microarraygpr.gpr_title + " => !" +  @microarraygpr.gpr_file_title  
        return false
      end

      # Open a file in read-only mode and print each line to the console
      path = File.join(@microarraygpr.gpr_file_title, @microarraygpr.gpr_title)
      logger.debug "File extract local path: " + path
      file = File.open(path , 'r') do |f|   #'afile.txt'
        f.each do |line|
          logger.debug "[" + f.lineno.to_s + "]" + line
          columns = line.split(",")
#         break if file.lineno > 10
        end
      end


    rescue => err
      flash.now[:error] = "Exception extractFile: #{err}..."
      #print to the console       puts "Exception: #{err}"
      logger.error "Microarraygpr extractFile error: " + err.message  
      logger.error err.backtrace.inspect
      return false
    end

    return true
  end


  def parse_header
  
      begin
      logger.debug "::::::::::::::::::::microarray GPR extract data (" + current_user.name +     "):::::::::::::::::::: "

      if @microarraygpr.id.to_s == "" 
        logger.debug "microarray GPR not saved on database. Header parsing aborted"  
        return false
      end
      logger.debug "microarray GPR parse data for id " + @microarraygpr.id.to_s
      if @microarraygpr.gpr_file_title == "" or @microarraygpr.gpr_title == ""
        logger.debug "microarray GPR file not found. Parsing aborted " + @microarraygpr.gpr_title + " => !" +  @microarraygpr.gpr_file_title  
        return false
      end

       
       @gpr_header = GprHeader.new(params[:gpr_header])
       
       path = File.join(@microarraygpr.gpr_file_title, @microarraygpr.gpr_title)
       str = IO.read(path)
       line = str.to_str
       if line =~ /(^ATF\s)(\d)/m 
       	  @gpr_header.gprVersion = $2.to_s
       end
       if line =~ /\bType=(.[^"]*)/m 
          @gpr_header.gprtype = $1.to_s
       end
       if line =~ /DateTime=(.[^"]*)/m 
          @gpr_header.datetime = $1.to_s
       end 
       if line =~ /Settings=(.[^"]*)/m 
          @gpr_header.settings = $1.to_s
       end
       if line =~ /GalFile=(.[^"]*)/m 
          @gpr_header.galfile = $1.to_s
       end
       if line =~ /PixelSize=(.[^"]*)/m
          @gpr_header.pixelsize = $1.to_s
       end 
 
       if line =~ /Wavelengths=(.[^"]*)/m
          @gpr_header.wavelengths = $1.to_s
       end 

       if line =~ /ImageFiles=(.[^"]*)/m
          @gpr_header.imagefiles = $1.to_s
       end 

       if line =~ /"NormalizationMethod=(.[^"]*)/m
          @gpr_header.normalizationmethod = $1.to_s
       end 

       if line =~ /NormalizationFactors=(.[^"]*)/m
          @gpr_header.normalizationfactors = $1.to_s
       end 

       if line =~ /JpegImage=(.[^"]*)/m
          @gpr_header.jpegimage = $1.to_s
       end 

       if line =~ /StdDev=(.[^"]*)/m
          @gpr_header.stddev = $1.to_s
       end 

       if line =~ /RatioFormulations=(.[^"]*)/m
          @gpr_header.ratioformulations = $1.to_s
       end

       if line =~ /FeatureType=(.[^"]*)/m
          @gpr_header.featuretype = $1.to_s
       end

       if line =~ /Barcode=(.[^"]*)/m
          @gpr_header.barcode = $1.to_s
       end

       if line =~ /BackgroundSubtraction=(.[^"]*)/m
          @gpr_header.backgroundsubtraction = $1.to_s
       end

       if line =~ /ImageOrigin=(.[^"]*)/m
          @gpr_header.imageorigin = $1.to_s
       end

       if line =~ /JpegOrigin=(.[^"]*)/m
          @gpr_header.jpegorigin = $1.to_s
       end

       if line =~ /Creator=(.[^"]*)/m
          @gpr_header.creator = $1.to_s
       end

       if line =~ /Scanner=(.[^"]*)/m
          @gpr_header.scanner = $1.to_s
       end 
        
       if line =~ /FocusPosition/m
          @gpr_header.focusposition = $1.to_s
       end

       if line =~ /Temperature=(.[^"]*)/m
          @gpr_header.temp = $1.to_s
       end

       if line =~ /LinesAveraged=(.[^"]*)/m
          @gpr_header.linesavg = $1.to_s
       end

       if line =~ /Comment=(.[^"]*)/m
          @gpr_header.comment = $1.to_s
       end

       if line =~ /PMTGain=(.[^"]*)/m
          @gpr_header.pmtgain = $1.to_s
       end

       if line =~ /ScanPower=(.[^"]*)/m
          @gpr_header.scanpower = $1.to_s
       end

       if line =~ /LaserPower=(.[^"]*)/m
          @gpr_header.laserpower = $1.to_s
       end

       if line =~ /Filters=(.[^"]*)/m
          @gpr_header.filters = $1.to_s
       end

       if line =~ /ScanRegion=(.[^"]*)/m
          @gpr_header.scanregion = $1.to_s
       end

       if line =~ /Supplier=(.[^"]*)/m
          @gpr_header.supplier = $1.to_s
       end

    
       @gpr_header.microarraygpr_id = @microarraygpr.id 
       
       @gpr_header.save

      rescue => err
      flash.now[:error] = "Exception parse_file: #{err}..."
      #print to the console       puts "Exception: #{err}"
      logger.error "microarraygpr parse_file error: " + err.message  
      logger.error err.backtrace.inspect
      return false
 
    end

  end


  def parse_gpr_data
  
   begin
      logger.debug "::::::::::::::::::::microarray GPR parse oligo data (" + current_user.name +     "):::::::::::::::::::: "

      if @microarraygpr.id.to_s == "" 
        logger.debug "microarray GPR not saved on database. Parsing gpr data aborted"  
        return false
      end
      logger.debug "microarray GPR parse data for id " + @microarraygpr.id.to_s
      if @microarraygpr.gpr_file_title == "" or @microarraygpr.gpr_title == ""
        logger.debug "microarray GPR file not found. Parsing aborted " + @microarraygpr.gpr_title + " => !" +  @microarraygpr.gpr_file_title  
        return false
      end	
      
       #@microarraygal = Microarraygal.find(params[:id])
       path = File.join(@microarraygpr.gpr_file_title, @microarraygpr.gpr_title)
       str = IO.read(path)
       line = str.to_str

   data = line.scan(/(\d{1,2}[\s\t,]\d{1,2}[\s\t,]\d{1,2}[\s\t,].[a-zA-Z0-9_]+.[\s\t,].[a-zA-Z0-9_]+.[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]\d{0,6}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,][\w+\-\d+.\d]{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,]-?\S{0,10}[\s\t,])/).flatten

logger.debug "::::::::::::::::::::micro array download data (" + data.join(',') + "):::::::::::::::::::: "

              data.each do |line|
           
               @gpr_datas = GprData.create!(params[:gpr_datas])
        
               if line =~ /(\d{1,2})[\s\t,](\d{1,2})[\s\t,](\d{1,2})[\s\t,].([a-zA-Z0-9_]+).[\s\t,].([a-zA-Z0-9_]+).[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](\d{0,6})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,]([\w+\-\d+.\d]{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})[\s\t,](-?\S{0,10})/
 
			@gpr_datas.gal_block_id = $1.to_s
			@gpr_datas.oligo_column = $2.to_s
			@gpr_datas.oligo_row = $3.to_s
			@gpr_datas.oligo_name = $4.to_s
			@gpr_datas.oligo_id = $5
			@gpr_datas.x = $6.to_s
			@gpr_datas.y = $7.to_s
			@gpr_datas.dia = $8.to_s
			@gpr_datas.f635_median = $9.to_s
                        @gpr_datas.f635_mean = $10.to_s
			@gpr_datas.f635_sd = $11.to_s
			@gpr_datas.f635_cv = $12.to_s
                        @gpr_datas.b635 = $13.to_s
			@gpr_datas.b635_Median = $14.to_s
			@gpr_datas.b635_mean = $15.to_s
			@gpr_datas.b635_sd = $16.to_s
			@gpr_datas.b635_cv = $17.to_s
			@gpr_datas.percent_b635_1_sd = $18.to_s
                        @gpr_datas.percent_b635_2_sd = $19.to_s
			@gpr_datas.f635_perc_sat = $20.to_s
			@gpr_datas.f532_median = $21.to_s
			@gpr_datas.f532_mean = $22.to_s
			@gpr_datas.f532_sd = $23.to_s
			@gpr_datas.f532_cv = $24.to_s
			@gpr_datas.b532 = $25.to_s
			@gpr_datas.b532_median = $26.to_s
			@gpr_datas.b532_mean = $27.to_s
                        @gpr_datas.b532_sd = $28.to_s
			@gpr_datas.b532_cv = $29.to_s
			@gpr_datas.percent_b532_1_sd = $30.to_s
			@gpr_datas.percent_b532_2_sd = $31.to_s
			@gpr_datas.f532_perc_sat = $32.to_s
			@gpr_datas.ratio_of_medians = $33.to_s
			@gpr_datas.ratio_of_means = $34.to_s
			@gpr_datas.median_of_ratios = $35.to_s
			@gpr_datas.mean_of_ratios = $36.to_s
                        @gpr_datas.ratios_sd = $37.to_s
			@gpr_datas.rgn_ratio = $38.to_s
			@gpr_datas.rgn_r2 = $39.to_s
			@gpr_datas.f_pixels = $40.to_s
			@gpr_datas.b_pixels = $41.to_s
			@gpr_datas.circularity = $42.to_s
			@gpr_datas.sum_of_medians = $43.to_s
			@gpr_datas.sum_of_means = $44.to_s
                        @gpr_datas.log_ratio = $45.to_s
                        @gpr_datas.f635_median_minus_b635 = $46.to_s
			@gpr_datas.f532_median_minus_b635 = $47.to_s
			@gpr_datas.f635_mean_minus_b635 = $48.to_s
			@gpr_datas.f532_mean_minus_b635 = $49.to_s
			@gpr_datas.f635_total_intensity = $50.to_s
			@gpr_datas.f532_total_intensity = $51.to_s
			@gpr_datas.snr_635 = $52.to_s
			@gpr_datas.snr_532 = $53.to_s
                        @gpr_datas.flags = $54.to_s
			@gpr_datas.normalize = $55.to_s
			@gpr_datas.autoflag = $56.to_s

                end

         @gpr_datas.microarraygpr_id = @microarraygpr.id 
         @gpr_datas.gpr_header_id = @gpr_header.id
         @gpr_datas.save

         end 
    
      rescue => err
      
      flash.now[:error] = "Exception parse_file: #{err}..."
      #print to the console       puts "Exception: #{err}"
      logger.error "microarray gpr data parse_file error: " + err.message  
      logger.error err.backtrace.inspect
      
      return false
 
    end


  end




  #<%= link_to "Download File", @microarraygpr.path %> --> Kappao need Route
  def download_csv
    begin
      logger.debug "::::::::::::::::::::micro array download data (" + current_user.name + "):::::::::::::::::::: "

      @microarraygpr = Microarraygpr.find(params[:id])
      @filename = File.join(@microarraygpr.gpr_file_title, @microarraygpr.gpr_title)

      if FileTest.exist?(@filename)
        #send_file(@filename, :type => 'text/csv', :x_sendfile => true, :filename => @microarraygpr.gpr_title)
        send_file(@filename, :type => 'text/csv', :filename => @microarraygpr.gpr_title)
        #render :file => @filename
      else
        logger.debug "File not found: " + @filename
        render :text => 'private_files_controller.not_found', :status => 404
      end 

    rescue => err
      flash.now[:error] = "Exception extractFile: #{err}..."
      logger.warn("#{Time.now} - Unknown type requested: #{params.inspect}")
      #render :text => t('private_files_controller.bad_request'), :status => 400
      render :text => 'private_files_controller.unauthorized: ' + err, :status => 401
      return false
    end
  
  end 

  # PUT /microarraygprs/1
  # PUT /microarraygprs/1.xml
  def update
    @microarraygpr = Microarraygpr.find(params[:id])
    @title = "Micro array"

    respond_to do |format|
      if @microarraygpr.update_attributes(params[:microarraygpr])
        format.html { redirect_to(@microarraygpr, :notice => 'Microarraygpr was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @microarraygpr.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /microarraygprs/1
  # DELETE /microarraygprs/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to water_types_path
    else

        @microarraygpr = Microarraygpr.find(params[:id])
        @microarraygpr.destroy
        @title = "Micro array"

        #Cascading delete all children
        # --> delete all microarraygpr_validations
        # --> delete all microarraygpr_analysis_files
        # --> delete all microarraygpr_datas
        # --> delete all microarraygpr_images

        @filename = File.join(@microarraygpr.gpr_file_title, @microarraygpr.gpr_title)
        File.delete(@filename) if File.exist?(@filename)

        respond_to do |format|
          format.html { redirect_to(microarraygprs_url) }
          format.xml  { head :ok }
        end
    end
  end

  private

    def correct_user
      @ma = Microarraygpr.find(params[:id])
      @partner = Partner.find(@ma.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end
   

    def reroute()
      flash.now[:notice] = "Only the partner who create the micro array can modify it."
      redirect_to(microarraygprs_path)
    end





end
