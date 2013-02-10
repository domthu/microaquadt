class MicroarraygalsController < ApplicationController
  
  class UnknownTypeError < StandardError
  end
  
   #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update] #, :download_csv]
  after_filter :extractFile, :only => [:create]


  # GET /microarraygals
  # GET /microarraygals.xml
  def index
    @microarraygals = Microarraygal.all
    @title = "List of micro arrays GAL files"

    microarraygals = Microarraygal.find(:all, :joins=>[:partner]) do
        #if params[:_search] == "true"

       # end
        paginate :page => params[:page], :per_page => params[:rows]      
     
     end

    respond_to do |format|
        format.html # index.html.erbs directly,
        #format.xml  { render :xml => @samplings }
 format.json { render :json => microarraygals.to_jqgrid_json([:id,"act","gal_f_code","partner_name","title","bcode","gal_upload_date","edit"], params[:page], params[:rows], microarraygals.total_entries) }			
    end
 end

  # GET /microarraygals/1
  # GET /microarraygals/1.xml
  def show
    @microarraygal = Microarraygal.find(params[:id])
    @title = "Microarray GAL files"

    if @microarraygal.nil?
        redirect_to :action => "index"
    end
    @pt = Partner.find(@microarraygal.partner_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @microarraygal }
    end
  end


  # GET /microarraygals/new
  # GET /microarraygals/new.xml
  def new
    logger.debug "::::::::::::::::::::micro array create new (" + current_user.name + "):::::::::::::::::::: "	
    @microarraygal = Microarraygal.new
    @title = "Microarray GAL files"

    @partners = Partner.find(:all)
    @pt = get_partner
    unless @pt.nil?
      #set the selected item
      @microarraygal.partner_id = @pt.id
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @microarraygal }
    end
  end

  # GET /microarraygals/1/edit
  def edit
    @microarraygal = Microarraygal.find(params[:id])
    @title = "Microarray GAL files"
  end

  # POST /microarraygals
  # POST /microarraygals.xml
  def create
  logger.debug "::::::::::::::::::::micro array create action (" + current_user.name + "):::::::::::::::::::: "
    @microarraygal = Microarraygal.new(params[:microarraygal])
    @title = "Microarray GAL files"

    @valid = false
    if @microarraygal.partner.nil?
      flash.now[:error] = "No partner found for this microarray .gal upload!!!"
      @valid = true
    end

    if @valid
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @microarraygal.errors, :status => :unprocessable_entity }
      end
     return 
    end

    @savedFile = false
    
    begin
        uploaded_io = params[:microarraygal][:gal_file]
        
        if uploaded_io.to_s == "" 
          flash.now[:notice] = "File not selected. Empty..."
          logger.debug "microarraygal create: dowload GAL file empty"  
        else
            name =  Time.now.strftime("%Y%m%d%H%M%S ") + sanitize_filename(uploaded_io.original_filename)
            logger.debug "File uploaded original name: " + name + ", type: " + uploaded_io.content_type 
            directory = "public/microarrays/"  
            Dir.mkdir(directory) unless File.directory?(directory)
            path = File.join(directory, name)
            File.open(path, "wb") { |file| file.write(uploaded_io.read) }                                   
            @microarraygal.gal_title = name 
            @microarraygal.gal_file_title = directory
            @savedFile = true

        end

        if @savedFile == false
          respond_to do |format|
            flash.now[:error] = "Error loading File"
            format.html { render :action => "new" }
            format.xml  { render :xml => @microarraygal.errors, :status => :unprocessable_entity }
          end
          return
        end
 
       #rescue Exception => err  
    rescue => err
      flash.now[:error] = "Exception: #{err}..."
      #print to the console
      puts "Exception: #{err}"
      logger.error "microarray GAL dowload file: " + err.message  
      logger.error err.backtrace.inspect
    end

    respond_to do |format|
      if @savedFile and @microarraygal.save
        #SavedFile now Extract Data
        self.extractFile
        self.parse_header
        self.parse_blocks
        self.parse_oligo_data
        format.html { 
            flash[:notice] = 'Microarray GAL file is successfully saved. Upload GPR file or Create new Microarray Experiment by associating your GAL file!!!'
      redirect_to :controller => "microarraygprs", :action => "new" }
        format.xml  { render :xml => @microarraygal, :status => :created, :location => @microarraygal }
      else
        @partners = Partner.find(:all)
        @pt = get_partner
		unless @pt.nil?
		  #set the selected item
		  @microarraygal.partner_id = @pt.id
		end

        format.html { render :action => "new" }
        format.xml  { render :xml => @microarraygal.errors, :status => :unprocessable_entity }
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
  
  def parse_header
 
   begin
      logger.debug "::::::::::::::::::::microarray GAL extract data (" + current_user.name +     "):::::::::::::::::::: "

      if @microarraygal.id.to_s == "" 
        logger.debug "microarray GAL not saved on database. Header parsing aborted"  
        return false
      end
      logger.debug "microarray GAL parse data for id " + @microarraygal.id.to_s
      if @microarraygal.gal_file_title == "" or @microarraygal.gal_title == ""
        logger.debug "microarray GAL file not found. Parsing aborted " + @microarraygal.gal_title + " => !" +  @microarraygal.gal_file_title  
        return false
      end

       #@microarraygal = Microarraygal.find(params[:id])
       @gal_header = GalHeader.new(params[:gal_header])
       #name = Microarraygal.find(params[:id]).gal_title
       #directory = "public/microarrays/"  
       #path1 = File.join(directory, name)
       path = File.join(@microarraygal.gal_file_title, @microarraygal.gal_title)
       str = IO.read(path)
       line = str.to_str
       if line =~ /(^ATF\s)(\d)/m 
       	  @gal_header.gal_version_info = $2.to_s
       end
       if line =~ /Block\d=\s?\d+,\s?\d+,\s?\d+,\s?(\d+),\s?\d+,\s?\d+,\s?\d+[\s\n\b\r\t]/m 
          @gal_header.gal_row_count = $1.to_s
       end
       if line =~ /Block\d=\s?\d+,\s?\d+,\s?\d+,\s?\d+,\s?\d+,\s?(\d+),\s?\d+[\s\n\b\r\t]/m 
          @gal_header.gal_column_count = $1.to_s
       end 
       if line =~ /(BlockType=)(\d)/m 
          @gal_header.block_type = $2.to_s
       end
       if line =~ /(BlockCount=)(\d)/m 
          @gal_header.block_count = $2.to_s
       end
       if line =~ /(Supplier=)(\w+)/m
          @gal_header.supplier = $2.to_s
       end 
        
       @gal_header.microarraygal_id = @microarraygal.id 
       
       @gal_header.save

      rescue => err
      flash.now[:error] = "Exception parse_file: #{err}..."
      #print to the console       puts "Exception: #{err}"
      logger.error "microarray parse_file error: " + err.message  
      logger.error err.backtrace.inspect
      return false
 
    end
  end
 
  def parse_blocks
 
   begin
      logger.debug "::::::::::::::::::::microarray GAL parse data (" + current_user.name +     "):::::::::::::::::::: "

      if @microarraygal.id.to_s == "" 
        logger.debug "microarray GAL not saved on database. Block parsing aborted"  
        return false
      end
      logger.debug "microarray GAL parse blocks for id " + @microarraygal.id.to_s
      if @microarraygal.gal_file_title == "" or @microarraygal.gal_title == ""
        logger.debug "microarray GAL file not found. Parsing aborted " + @microarraygal.gal_title + " => !" +  @microarraygal.gal_file_title  
        return false
      end

       #@microarraygal = Microarraygal.find(params[:id])
       path = File.join(@microarraygal.gal_file_title, @microarraygal.gal_title)
       str = IO.read(path)
       line = str.to_str
       if line =~ /(^Block\d.+)?Block\s/m
        $1.each do |line|
           
              @gal_blocks = GalBlock.new(params[:gal_blocks])
        
              if line =~ /Block(\d)=\s?(\d+),\s?(\d+),\s?(\d+),\s?(\d+),\s?(\d+),\s?(\d+),\s?(\d+)[\s\n\b\r\t]/

		@gal_blocks.block_number = $1.to_s 
                @gal_blocks.xOrigin = $2.to_s
                @gal_blocks.yOrigin = $3.to_s 		  
                @gal_blocks.feature_diameter = $4.to_s 		     
                @gal_blocks.xFeatures = $5.to_s 
                @gal_blocks.xSpacing = $6.to_s
                @gal_blocks.yFeatures = $7.to_s		  	   
                @gal_blocks.ySpacing = $8.to_s
                 
             end
         @gal_blocks.microarraygal_id = @microarraygal.id 
         @gal_blocks.gal_header_id = @gal_header.id
         @gal_blocks.save
        end
      end 
        
       
       

      rescue => err
      flash.now[:error] = "Exception parse_file: #{err}..."
      #print to the console       puts "Exception: #{err}"
      logger.error "microarray parse_file error: " + err.message  
      logger.error err.backtrace.inspect
      return false
 
    end
  end


  def parse_oligo_data
 
   begin
      logger.debug "::::::::::::::::::::microarray GAL parse oligo data (" + current_user.name +     "):::::::::::::::::::: "

      if @microarraygal.id.to_s == "" 
        logger.debug "microarray GAL not saved on database. Parsing oligo data aborted"  
        return false
      end
      logger.debug "microarray GAL parse oligo data for id " + @microarraygal.id.to_s
      if @microarraygal.gal_file_title == "" or @microarraygal.gal_title == ""
        logger.debug "microarray GAL file not found. Parsing aborted " + @microarraygal.gal_title + " => !" +  @microarraygal.gal_file_title  
        return false
      end
      
       #@microarraygal = Microarraygal.find(params[:id])
       path = File.join(@microarraygal.gal_file_title, @microarraygal.gal_title)
       str = IO.read(path)
       line = str.to_str
       
       #if line =~ /(\d+\s\d+\s\d+\s\d+\s\w+[+\-\s\w]+)/m

       #if we are not including IDs and gal having same data in ID and Name column
       data = line.scan(/\d+[\s\t]\d+[\s\t]\d+[\s\t][\w\d][a-zA-Z0-9_\-]+[\s\t][\w\d][a-zA-Z0-9_\-]+/).flatten

        #$1.each do |line|

        data.each do |line|
           
              @oligos = Oligo.new(params[:oligos])
        
              #if line =~ /(\d+)\s(\d+)\s(\d+)\s(\d+)\s(\w+[+\-\s\w]+)/
      
      #if we are not including IDs and gal having same data in ID and Name column
      if line =~ /(\d+)[\s\t](\d+)[\s\t](\d+)[\s\t]([\w\d][a-zA-Z0-9_\-]+)[\s\t]([\w\d][a-zA-Z0-9_\-]+)/

		@oligos.gal_block_id = $1.to_s 
                @oligos.row_number = $2.to_s
                @oligos.column_number = $3.to_s 		  
                @oligos.oligo_id = $4.to_s 		     
                @oligos.code = $5.to_s 
                 
             end
         @oligos.microarraygal_id = @microarraygal.id 
         @oligos.gal_header_id = @gal_header.id
         @oligos.save
        end
      #end 
   
      rescue => err
      flash.now[:error] = "Exception parse_file: #{err}..."
      #print to the console       puts "Exception: #{err}"
      logger.error "microarray parse_file error: " + err.message  
      logger.error err.backtrace.inspect
      return false
 
    end
  end
  
 

   def extractFile
    begin
      logger.debug "::::::::::::::::::::microarray GAL extract data (" + current_user.name + "):::::::::::::::::::: "
      if @microarraygal.id.to_s == "" 
        logger.debug "microarray GAL not saved on database. Extraction routine aborted"  
        return false
      end
      logger.debug "microarray GAL extract data for id " + @microarraygal.id.to_s
 
      if @microarraygal.gal_file_title == "" or @microarraygal.gal_title == ""
        logger.debug "microarray GAL file not found. Extraction routine aborted " + @microarraygal.gal_title + " => !" +  @microarraygal.gal_file_title  
        return false
      end

      # Open a file in read-only mode and print each line to the console
      path = File.join(@microarraygal.gal_file_title, @microarraygal.gal_title)
      logger.debug "File extract local path: " + path
      file = File.open(path , 'r') do |f|   #'afile.txt'
             f.each do |line|
           logger.debug "[" + f.lineno.to_s + "]" + line
             columns = line.split(",") 
            end
          end 

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
      logger.debug "::::::::::::::::::::microarray GAL download data (" + current_user.name + "):::::::::::::::::::: "

      @microarraygal = Microarraygal.find(params[:id])
      @filename = File.join(@microarraygal.gal_file_title, @microarraygal.gal_title)

      if FileTest.exist?(@filename)
        #send_file(@filename, :type => 'text/csv', :x_sendfile => true, :filename => @micro_array.gpr_title)
        send_file(@filename, :type => 'text/csv', :filename => @microarraygal.gal_title)
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

  
 # PUT /microarraygals/1
  # PUT /microarraygals/1.xml
  def update
    @microarraygal = Microarraygal.find(params[:id])
    @title = "Microarray GAL files"

    respond_to do |format|
      if @microarraygal.update_attributes(params[:microarraygal])
        format.html { redirect_to(@microarraygal, :notice => 'Microarraygal was successfully updated.') }
        format.xml  { head :ok }
       else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @microarraygal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /microarraygals/1
  # DELETE /microarraygals/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to microarraygals_path
    else

    @microarraygal = Microarraygal.find(params[:id])
    @microarraygal.destroy
    @title = "Microarray GAL files"

    @filename = File.join(@microarraygal.gal_file_title, @microarraygal.gal_title)
        File.delete(@filename) if File.exist?(@filename)

      respond_to do |format|
       format.html { redirect_to(microarraygals_url) }
       format.xml  { head :ok }
      end
    end
  end



 private

    def correct_user
      @mag = Microarraygal.find(params[:id])
      @partner = Partner.find(@mag.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash.now[:notice] = "Only the partner who create the micro array can modify it."
      redirect_to(micro_arrays_path)
    end

end


#DOWLOAD FILE FROM SERVER TO CLIENT
    # attachment_fu
    # http://guides.rubyonrails.org/security.html#executable-code-in-file-uploads
    # The send_file() method sends files from the server to the client

#READ FILE
    #forms rendered using form_for @micro_array have their encoding set to multipart/form-data automatically

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

