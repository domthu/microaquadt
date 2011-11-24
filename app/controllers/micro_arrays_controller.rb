class MicroArraysController < ApplicationController

  class UnknownTypeError < StandardError
  end

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update] #, :download_csv]
  after_filter :extractFile, :only => [:create]

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


    #DOWLOAD FILE FROM SERVER TO CLIENT
    # attachment_fu
    # http://guides.rubyonrails.org/security.html#executable-code-in-file-uploads
    # The send_file() method sends files from the server to the client

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @micro_array }
      format.csv { download_csv }
    end
  end

  # GET /micro_arrays/new
  # GET /micro_arrays/new.xml
  def new
    logger.debug "::::::::::::::::::::micro array create new (" + current_user.name + "):::::::::::::::::::: "
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
    logger.debug "::::::::::::::::::::micro array create action (" + current_user.name + "):::::::::::::::::::: "
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
      return 
    end

    @savedFile = false
    #READ FILE
    #forms rendered using form_for @micro_array have their encoding set to multipart/form-data automatically
    begin
        uploaded_io = params[:micro_array][:gpr_file]
        
        if uploaded_io.to_s == "" 
          flash.now[:notice] = "File not selected. Empty..."
          logger.debug "microarray create: dowload file empty"  
        else
            name =  Time.now.strftime("%Y%m%d%H%M%S ") + sanitize_filename(uploaded_io.original_filename)
            logger.debug "File uploaded original name: " + name + ", type: " + uploaded_io.content_type 
            directory = "public/microarrays/"  
            Dir.mkdir(directory) unless File.directory?(directory)
            path = File.join(directory, name)
            File.open(path, "wb") { |file| file.write(uploaded_io.read) }                                   
            @micro_array.gpr_title = name 
            @micro_array.gpr_file_title = directory
            @savedFile = true
        end
 
        if @savedFile == false
          respond_to do |format|
            flash.now[:error] = "Error loading File"
            format.html { render :action => "new" }
            format.xml  { render :xml => @micro_array.errors, :status => :unprocessable_entity }
          end
          return
        end

    #rescue Exception => err  
    rescue => err
      flash.now[:error] = "Exception: #{err}..."
      #print to the console
      puts "Exception: #{err}"
      logger.error "microarray dowload file: " + err.message  
      logger.error err.backtrace.inspect
    end

    respond_to do |format|
      if @savedFile and @micro_array.save
        #SavedFile now Extract Data
        self.extractFile
        format.html { redirect_to(@micro_array, :notice => 'MicroArray was successfully created.') }
        format.xml  { render :xml => @micro_array, :status => :created, :location => @micro_array }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @micro_array.errors, :status => :unprocessable_entity }
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

  #POO http://www.practicalecommerce.com/blogs/post/105-File-Uploads-with-Ruby-on-Rails
  #--> Idea By assigning an attribute accessor called media in my model using the following code:
  #  def media=(data)  
  #    if data != “”  
  #    name = base_part_of(data.original_filename)  
  #    directory = “public/uploads/” + Time.now.to_s(:file)
  #    path = File.join(directory, name)
  #    Dir.mkdir(directory) unless File.directory?(directory)
  #    File.open(path, “wb”) { |f| f.write(data.read) }
  #    self.name   = name
  #    self.mime   = data.content_type.chomp
  #    self.path   = path.gsub(/public/, ‘’)
  #    end
  #  end

#  def saveFile(uploaded_io)
#    begin
#      #What Gets Uploaded? 
#        #The object is depending of the size: it may in fact be a StringIO or an instance of File backed by a temporary file
#        #        content = uploaded_io.is_a?(StringIO) ? uploaded_io.read : File.read(uploaded_io.local_path)
#        #        # Alway attributes original_filename attribute containing the name the file and a content_type 
#        #        logger.debug "File uploaded: " + content.original_filename + ", type: " + content.content_type 
#        #        savedFile = saveFile(content)
#        #        --> Exception: undefined method `local_path' for "datafields.csv":String...

#      #debugger
#      #If the user has not selected a file the corresponding parameter will be an empty string.
#      # .nil? , .empty?, .blank?(rails)
#      #if uploaded_io.empty? or uploaded_io == "" 
#      if uploaded_io.to_s == "" 
#        logger.debug "microarray create: dowload file empty"  
#        return false
#      end
#      # Alway attributes original_filename attribute containing the name the file and a content_type 
#      name =  uploaded_io.original_filename
#      logger.debug "File uploaded original name: " + name + ", type: " + uploaded_io.content_type 
#      #name =  uploaded_io
#      #logger.debug "File uploaded original name: " + name 
#      
#      #see environment.rb initializer
#      directory = "public/microarrays/" + Time.now.to_s(:date_time_file)
#      Dir.mkdir(directory) unless File.directory?(directory)
#      # create the file path 
#      #File is a ruby object and join is a helper function will concatenate directory name alongwith file name and will return full file path.
#      path = File.join(directory, name)
#      logger.debug "File uploaded file join path: " + path
#      
#      # write the file
#      # to open a file in write mode we are using open helper function provided by File object. Further we are reading data from the passed data file and writing into output file.
#      File.open(path, "wb") { |file| file.write(uploaded_io.read) }

#   
##      # Save file from teporary to classified direttory
##      #The following snippet saves the uploaded content in #{Rails.root}/public/microarrays 
##      #under the same name as the original file (assuming the form was the one in the previous example).
##      path = Rails.root.join('public', 'microarrays', name)
##      logger.debug "File uploaded Rails root join path: " + path
##      file = File.open(path, 'w') do |file|
##        file.write(uploaded_io.read)
##      end
#    rescue => err
#      flash.now[:error] = "Exception saveFile: #{err}..."
#      #print to the console       puts "Exception: #{err}"
#      logger.error "microarray saveFile error: " + err.message  
#      logger.error err.backtrace.inspect
#      return false
#    end

#    return true
#  end
 

  #def extractFile(@micro_array)
  def extractFile
    begin
      logger.debug "::::::::::::::::::::micro array extract data (" + current_user.name + "):::::::::::::::::::: "
      if @micro_array.id.to_s == "" 
        logger.debug "microarray not saved on database. Extraction routine aborted"  
        return false
      end
      logger.debug "micro array extract data for id " + @micro_array.id.to_s
 
      if @micro_array.gpr_file_title == "" or @micro_array.gpr_title == ""
        logger.debug "microarray file not found. Extraction routine aborted " + @micro_array.gpr_title + " => !" +  @micro_array.gpr_file_title  
        return false
      end

      # Open a file in read-only mode and print each line to the console
      path = File.join(@micro_array.gpr_file_title, @micro_array.gpr_title)
      logger.debug "File extract local path: " + path
      file = File.open(path , 'r') do |f|   #'afile.txt'
        f.each do |line|
          logger.debug "[" + f.lineno.to_s + "]" + line
          columns = line.split(",")
#         break if file.lineno > 10
        end
      end


#      begin
#        require "faster_csv"
#        FasterCSV.build_csv_interface
#      rescue LoadError
#        require "csv"
#      end

    rescue => err
      flash.now[:error] = "Exception extractFile: #{err}..."
      #print to the console       puts "Exception: #{err}"
      logger.error "microarray extractFile error: " + err.message  
      logger.error err.backtrace.inspect
      return false
    end

    return true
  end

  #<%= link_to "Download File", @micro_array.path %> --> Kappao need Route
  def download_csv
    begin
      logger.debug "::::::::::::::::::::micro array download data (" + current_user.name + "):::::::::::::::::::: "

#    # Only respond to known types to avoid code injection attacks
#    raise UnknownTypeError unless %w(documents image_files audio video).member?(params[:type])
#    
#    # Ensure we load the correct object type
#    type = params[:type] == "audio" ? "audio_recordings" : params[:type]

      @micro_array = MicroArray.find(params[:id])
      @filename = File.join(@micro_array.gpr_file_title, @micro_array.gpr_title)

      if FileTest.exist?(@filename)
        #send_file(@filename, :type => 'text/csv', :x_sendfile => true, :filename => @micro_array.gpr_title)
        send_file(@filename, :type => 'text/csv', :filename => @micro_array.gpr_title)
        #render :file => @filename
      else
        logger.debug "File not found: " + @filename
        render :text => 'private_files_controller.not_found', :status => 404
      end 

#    rescue ActiveRecord::RecordNotFound
#      logger.warn("#{Time.now} - Requested File Not Found: #{params.inspect}")
#      render :text => t('private_files_controller.not_found'), :status => 404
#    rescue UnknownTypeError
#      logger.warn("#{Time.now} - Unknown type requested: #{params.inspect}")
#      render :text => t('private_files_controller.bad_request'), :status => 400
#    rescue PermissionDeniedError
#      logger.warn("#{Time.now} - Permission Denied While Requesting Private Item: #{params.inspect}")
#      render :text => t('private_files_controller.unauthorized'), :status => 401
    rescue => err
      flash.now[:error] = "Exception extractFile: #{err}..."
      logger.warn("#{Time.now} - Unknown type requested: #{params.inspect}")
      #render :text => t('private_files_controller.bad_request'), :status => 400
      render :text => 'private_files_controller.unauthorized: ' + err, :status => 401
      return false
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
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to water_types_path
    else

        @micro_array = MicroArray.find(params[:id])
        @micro_array.destroy
        @title = "Micro array"

        #Cascading delete all children
        # --> delete all micro_array_validations
        # --> delete all micro_array_analysis_files
        # --> delete all micro_array_datas
        # --> delete all micro_array_images

        @filename = File.join(@micro_array.gpr_file_title, @micro_array.gpr_title)
        File.delete(@filename) if File.exist?(@filename)

        respond_to do |format|
          format.html { redirect_to(micro_arrays_url) }
          format.xml  { head :ok }
        end
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
      flash.now[:notice] = "Only the partner who create the micro array can modify it."
      redirect_to(micro_arrays_path)
    end

end

#NEW


#<fieldset><legend class="leg">HEADER</legend>
#  <div class="field txt">
#    <%= f.label :H_name, "name" %><br />
#    <%= f.text_field :H_name %>
#  </div>
#  <div class="field num">
#    <%= f.label :H_ScanArrayCSVFileFormat, "ScanArrayCSVFileFormat" %><br />
#    <%= f.text_field :H_ScanArrayCSVFileFormat %>
#  </div>
#  <div class="field num">
#    <%= f.label :H_ScanArray_Express, "ScanArray Express" %><br />
#    <%= f.text_field :H_ScanArray_Express %>
#  </div>
#  <div class="field num">
#    <%= f.label :H_Number_of_Columns, "Columns" %><br />
#    <%= f.text_field :H_Number_of_Columns %>
#  </div>
#</fieldset>


#<fieldset><legend class="leg">GENERAL INFO</legend>
#  <div class="field date">
#    <%= f.label :I_DateTime, "Date Time" %><br />
#    <%= f.datetime_select :I_DateTime %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_GalFile, "GalFile" %><br />
#    <%= f.text_field :I_GalFile %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Scanner, "Scanner" %><br />
#    <%= f.text_field :I_Scanner %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_User_Name, "User name" %><br />
#    <%= f.text_field :I_User_Name %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Computer_Name, "Computer name" %><br />
#    <%= f.text_field :I_Computer_Name %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Protocol, "Protocol" %><br />
#    <%= f.text_field :I_Protocol %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Quantitation_Method, "Quantitation Method" %><br />
#    <%= f.text_field :I_Quantitation_Method %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Quality_Confidence_Calculation, "Quality Confidence Calculation" %><br />
#    <%= f.text_field :I_Quality_Confidence_Calculation %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_User_comments, "comments" %><br />
#    <%= f.text_area :I_User_comments %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Image_Origin, "Image Origin" %><br />
#    <%= f.text_field :I_Image_Origin %>
#  </div>
#  <div class="field num">
#    <%= f.label :I_Temperature, "Temperature" %><br />
#    <%= f.text_field :I_Temperature %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Laser_Powers, "Laser Powers" %><br />
#    <%= f.text_field :I_Laser_Powers %>
#  </div>
#  <div class="field num">
#    <%= f.label :I_Laser_On_Time, "" %><br />
#    <%= f.text_field :I_Laser_On_Time %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_PMT_Voltages, "PMT Voltages" %><br />
#    <%= f.text_field :I_PMT_Voltages %>
#  </div>
#</fieldset>



#<fieldset><legend class="leg">QUANTITATION PARAMETERS</legend>
#  <div class="field num">
#    <%= f.label :QP_Min_Percentile, "Min Percentile" %><br />
#    <%= f.text_field :QP_Min_Percentile %>
#  </div>
#  <div class="field num">
#    <%= f.label :QP_Max_Percentile, "Max Percentile" %><br />
#    <%= f.text_field :QP_Max_Percentile %>
#  </div>
#</fieldset>



#<fieldset><legend class="leg">QUALITY MEASUREMENTS</legend>
#  <div class="field num">
#    <%= f.label :QM_Max_Footprint, "Max Footprint" %><br />
#    <%= f.text_field :QM_Max_Footprint %>
#  </div>
#</fieldset>


#<fieldset><legend class="leg">ARRAY PATTERN INFO</legend>
#  <div class="field num">
#    <%= f.label :API_Units, "Units" %><br />
#    <%= f.text_field :API_Units %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Array_Rows, "Array rows" %><br />
#    <%= f.text_field :API_Array_Rows %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Array_Columns, "Array columns" %><br />
#    <%= f.text_field :API_Array_Columns %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Spot_Rows, "Spot rows" %><br />
#    <%= f.text_field :API_Spot_Rows %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Spot_Columns, "Spot columns" %><br />
#    <%= f.text_field :API_Spot_Columns %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Array_Row_Spacing, "Array Row Spacing" %><br />
#    <%= f.text_field :API_Array_Row_Spacing %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Array_Column_Spacing, "Array Column Spacing" %><br />
#    <%= f.text_field :API_Array_Column_Spacing %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Spot_Row_Spacing, "Spot Row Spacing" %><br />
#    <%= f.text_field :API_Spot_Row_Spacing %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Spot_Column_Spacing, "Spot Column Spacing" %><br />
#    <%= f.text_field :API_Spot_Column_Spacing %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Spot_Diameter, "Spot Diameter" %><br />
#    <%= f.text_field :API_Spot_Diameter %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Interstitial, "Interstitial" %><br />
#    <%= f.text_field :API_Interstitial %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Spots_Per_Array, "Spots Per Array" %><br />
#    <%= f.text_field :API_Spots_Per_Array %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Total_Spots, "Total Spots" %><br />
#    <%= f.text_field :API_Total_Spots %>
#  </div>
#</fieldset>

#IMAGE INFO see datatable associated...

#<fieldset><legend class="leg">NORMALIZATION INFO</legend>
#  <div class="field num">
#    <%= f.label :NI_Normalization_Method, "Normalization Method" %><br />
#    <%= f.text_field :NI_Normalization_Method %>
#  </div>
#</fieldset>

#DATA see datatable associated...



















#EDIT


#<fieldset><legend class="leg">General data</legend>
#  <div class="field select">
#    <%= f.label :partner_id, "Partner" %><br />
#    <div style="display:none;">  select :micro_array, :partner,Partner.find(:all).collect{|p| [p.fp7_Number + " " + p.name, p.id]} </div>
#    <h3><%= @partner.verbose_me %></h3>
#  </div>

#  <div class="field select">
#    <%= f.label :partner_id %><br />
#    <%= select :micro_array,:partner_id,Partner.find(:all).collect{|p| [p.verbose_me, p.id]}%>
#  </div>
#  <div class="field txt">
#    <%= f.label :gpr_title, "Title" %><br />
#    <%= f.text_field :gpr_title %>
#  </div>
#  <div class="field txt">
#    <%= f.label :gpr_file_title, "File name" %><br />
#    <%= f.text_field :gpr_file_title %>
#  </div>
#  <div class="field txt">
#    <%= f.label :gpr_file, "Load the grp file" %><br />
#    <%= file_field(:micro_array, :gpr_file) %>
#  </div>
#  <div class="field date">
#    <%= f.label :loaded_at, "Uploaded at" %><br />
#    <%= f.date_select :loaded_at %>
#  </div>
#</fieldset>


#<fieldset><legend class="leg">HEADER</legend>
#  <div class="field txt">
#    <%= f.label :H_name, "name" %><br />
#    <%= f.text_field :H_name %>
#  </div>
#  <div class="field num">
#    <%= f.label :H_ScanArrayCSVFileFormat, "ScanArrayCSVFileFormat" %><br />
#    <%= f.text_field :H_ScanArrayCSVFileFormat %>
#  </div>
#  <div class="field num">
#    <%= f.label :H_ScanArray_Express, "ScanArray Express" %><br />
#    <%= f.text_field :H_ScanArray_Express %>
#  </div>
#  <div class="field num">
#    <%= f.label :H_Number_of_Columns, "Columns" %><br />
#    <%= f.text_field :H_Number_of_Columns %>
#  </div>
#</fieldset>


#<fieldset><legend class="leg">GENERAL INFO</legend>
#  <div class="field date">
#    <%= f.label :I_DateTime, "Date Time" %><br />
#    <%= f.datetime_select :I_DateTime %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_GalFile, "GalFile" %><br />
#    <%= f.text_field :I_GalFile %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Scanner, "Scanner" %><br />
#    <%= f.text_field :I_Scanner %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_User_Name, "User name" %><br />
#    <%= f.text_field :I_User_Name %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Computer_Name, "Computer name" %><br />
#    <%= f.text_field :I_Computer_Name %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Protocol, "Protocol" %><br />
#    <%= f.text_field :I_Protocol %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Quantitation_Method, "Quantitation Method" %><br />
#    <%= f.text_field :I_Quantitation_Method %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Quality_Confidence_Calculation, "Quality Confidence Calculation" %><br />
#    <%= f.text_field :I_Quality_Confidence_Calculation %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_User_comments, "comments" %><br />
#    <%= f.text_area :I_User_comments %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Image_Origin, "Image Origin" %><br />
#    <%= f.text_field :I_Image_Origin %>
#  </div>
#  <div class="field num">
#    <%= f.label :I_Temperature, "Temperature" %><br />
#    <%= f.text_field :I_Temperature %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_Laser_Powers, "Laser Powers" %><br />
#    <%= f.text_field :I_Laser_Powers %>
#  </div>
#  <div class="field num">
#    <%= f.label :I_Laser_On_Time, "" %><br />
#    <%= f.text_field :I_Laser_On_Time %>
#  </div>
#  <div class="field txt">
#    <%= f.label :I_PMT_Voltages, "PMT Voltages" %><br />
#    <%= f.text_field :I_PMT_Voltages %>
#  </div>
#</fieldset>



#<fieldset><legend class="leg">QUANTITATION PARAMETERS</legend>
#  <div class="field num">
#    <%= f.label :QP_Min_Percentile, "Min Percentile" %><br />
#    <%= f.text_field :QP_Min_Percentile %>
#  </div>
#  <div class="field num">
#    <%= f.label :QP_Max_Percentile, "Max Percentile" %><br />
#    <%= f.text_field :QP_Max_Percentile %>
#  </div>
#</fieldset>



#<fieldset><legend class="leg">QUALITY MEASUREMENTS</legend>
#  <div class="field num">
#    <%= f.label :QM_Max_Footprint, "Max Footprint" %><br />
#    <%= f.text_field :QM_Max_Footprint %>
#  </div>
#</fieldset>


#<fieldset><legend class="leg">ARRAY PATTERN INFO</legend>
#  <div class="field num">
#    <%= f.label :API_Units, "Units" %><br />
#    <%= f.text_field :API_Units %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Array_Rows, "Array rows" %><br />
#    <%= f.text_field :API_Array_Rows %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Array_Columns, "Array columns" %><br />
#    <%= f.text_field :API_Array_Columns %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Spot_Rows, "Spot rows" %><br />
#    <%= f.text_field :API_Spot_Rows %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Spot_Columns, "Spot columns" %><br />
#    <%= f.text_field :API_Spot_Columns %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Array_Row_Spacing, "Array Row Spacing" %><br />
#    <%= f.text_field :API_Array_Row_Spacing %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Array_Column_Spacing, "Array Column Spacing" %><br />
#    <%= f.text_field :API_Array_Column_Spacing %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Spot_Row_Spacing, "Spot Row Spacing" %><br />
#    <%= f.text_field :API_Spot_Row_Spacing %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Spot_Column_Spacing, "Spot Column Spacing" %><br />
#    <%= f.text_field :API_Spot_Column_Spacing %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Spot_Diameter, "Spot Diameter" %><br />
#    <%= f.text_field :API_Spot_Diameter %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Interstitial, "Interstitial" %><br />
#    <%= f.text_field :API_Interstitial %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Spots_Per_Array, "Spots Per Array" %><br />
#    <%= f.text_field :API_Spots_Per_Array %>
#  </div>
#  <div class="field num">
#    <%= f.label :API_Total_Spots, "Total Spots" %><br />
#    <%= f.text_field :API_Total_Spots %>
#  </div>
#</fieldset>

#IMAGE INFO see datatable associated...

#<fieldset><legend class="leg">NORMALIZATION INFO</legend>
#  <div class="field num">
#    <%= f.label :NI_Normalization_Method, "Normalization Method" %><br />
#    <%= f.text_field :NI_Normalization_Method %>
#  </div>
#</fieldset>

#DATA see datatable associated...

