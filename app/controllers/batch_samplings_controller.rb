class BatchSamplingsController < ApplicationController
  

class UnknownTypeError < StandardError
end

 #before_filter :authorize, :only => [:edit, :update, :delete, :destroy]



  # GET /batch_samplings
  # GET /batch_samplings.xml
  def index
    @batch_samplings = BatchSampling.all
    @title = "Batch upload of Sampling data"

    if !signed_in?
	       flash.now[:notice] = "No Partner found!! Login with authenticated partner credentials!!!"
	       redirect_to samplings_path
    else

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @batch_samplings }
      end
    end
  end

  # GET /batch_samplings/1
  # GET /batch_samplings/1.xml
  def show
    @batch_sampling = BatchSampling.find(params[:id])
    @title = "Batch upload of Sampling data"
    

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @batch_sampling }
    end
  end

  # GET /batch_samplings/new
  # GET /batch_samplings/new.xml
  def new

    @batch_sampling = BatchSampling.new
    @title = "Batch upload of Sampling data"

	 if !signed_in?
	       flash.now[:notice] = "No Partner found!! Login with authenticated partner credentials!!!"
	       redirect_to samplings_path
	 else

	    10.times {@batch_sampling.sampling_assets.build}

	    respond_to do |format|
	     
		format.html # new.html.erb
		format.xml  { render :xml => @batch_sampling }
	       end
	 end
  end

  # GET /batch_samplings/1/edit
  def edit
    @batch_sampling = BatchSampling.find(params[:id])
    @title = "Batch upload of Sampling data"
    
  end

  # POST /batch_samplings
  # POST /batch_samplings.xml
  def create
    @batch_sampling = BatchSampling.new(params[:batch_sampling])
    @title = "Batch Upload of Sampling Data"

    respond_to do |format|
      if @batch_sampling.save
           
         id = @batch_sampling.id

 logger.debug "batch_sampling ID" + id.to_s

         self.parse_batch_sampling_data(id)

        format.html {
                      flash[:notice] = 'Files have been successfully saved and new Sampling entries are created!!!'
                      redirect_to :controller => "samplings", :action => "index" }

        format.xml  { render :xml => @batch_sampling, :status => :created, :location => @batch_sampling }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @batch_sampling.errors, :status => :unprocessable_entity }
      end
    end
  end

  def parse_batch_sampling_data(id)

     begin
      logger.debug "::::::::::::::::::::Sampling parse data (" + current_user.name +  "):::::::::::::::::::: "

      if @batch_sampling.id.to_s == "" 
        logger.debug "Sampling file not saved on database. Block parsing aborted. Batch sampling id not found"  
        return false
      end

      
      #logger.debug "Oligo Sequence file parse for id " + @batch_oligo.assets.find([:id]).id.to_s

      
      @batch_samplings = BatchSampling.find(id)

      #logger.debug "Batch samplings contains "+ @batch_samplings.sampling_assets.length.to_s 

      if @batch_samplings.sampling_assets.length > 1
      
          @batch_samplings.sampling_assets.each do |index|
     
          file_name = index.safi_file_name
	  directory = "/home/kumar/microaquadt/public/safis/"
          path = File.join(directory, file_name)
          str = IO.read(path)
          line = str.to_str	

		#logger.debug "Batch samplings contains "+ @batch_samplings.to_a 
		#logger.debug "filename "+ file_name.to_s  
		#logger.debug "path "+ path.to_s
       
                 
          data = line.scan(/(\w+[\t,]\w+[\t,]\d+[-\/]\d+[-\/]\d+[\t,]\d+[\t,].*?[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\w+[\D]*[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,][+-]*\d+[\s\n\r])/).flatten
	          
           logger.debug "Data array " + data.to_s
           	
           data.each do |line|		   
           
           @sampling = Sampling.new(params[:sampling])
		
         if line =~ /(\w+)[\t,](\w+)[\t,](\d+[-\/]\d+[-\/]\d+)[\t,](\d+)[\t,](.*?)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\w+[\D]*)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,]([+-]*\d+)[\n\r\s]/

 			#@sampling.sampling_site_id = $1.to_s
			#@sampling.partner_id = $2.to_s
			site_code = $1
                        @samplingsite = SamplingSite.find_by_code(site_code)
                        @sampling.sampling_site_id = @samplingsite.id
                        
                        ptr_code = $2
                        @ptnr = Partner.find_by_code(ptr_code)
                        @sampling.partner_id = @ptnr.id

                        @sampling.samplingDate = $3.to_s
			@sampling.volume = $4.to_s
			@sampling.note = $5.to_s
			@sampling.air_temperature = $6.to_s
			@sampling.moisture = $7.to_s
			@sampling.pressure = $8.to_s
			@sampling.windSpeed = $9.to_s
			@sampling.windDirection = $10.to_s                    
			@sampling.waterFlow = $11.to_s
			@sampling.lightIntensity = $12.to_s
			@sampling.rainfallEvents = $13.to_s
			@sampling.depth = $14.to_s
			@sampling.turbidity = $15.to_s
			@sampling.salinity = $16.to_s
			@sampling.tidalRange = $17.to_s
			@sampling.operators = $18.to_s
			@sampling.water_temperature = $19.to_s
			@sampling.conductivity = $20.to_s
			@sampling.phosphates = $21.to_s
			@sampling.nitrates = $22.to_s
			@sampling.ph = $23.to_s
			@sampling.nitrogen = $24.to_s
			@sampling.bod5 = $25.to_s
			@sampling.cod = $26.to_s
			@sampling.h2osat = $27.to_s
			@sampling.sampling_equipments_id = $28.to_s
			@sampling.storage = $29.to_s
		        		     
		        		         
		     end 		 

                 @pt = Partner.find(@sampling.partner_id)

                 @sampling.code = get_code(@pt, @sampling.samplingDate, nil)

                 @sampling.save

               end
            end

        else 
                
              file_name = @batch_samplings.sampling_assets.first.safi_file_name
              directory = "/home/kumar/microaquadt/public/safis/"
		       path = File.join(directory, file_name)
		       str = IO.read(path)
		       line = str.to_str	       
                  #if line =~ /\w+\s\w+[\t,][\S]+[\t,]\w+[\t,].*?[\t,]\d+-\d+-\d+[\t,]\d[\t,]\d+[\r\n]/m
            data = line.scan(/(\w+[\t,]\w+[\t,]\d+[-\/]\d+[-\/]\d+[\t,]\d+[\t,].*?[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\w+[\D]*[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,]\S+[\t,][+-]*\d+[\s\n\r])/).flatten
	          
           logger.debug "Data array " + data.to_s
           #$1.each do |line|	
           data.each do |line|		   
           
           @sampling = Sampling.new(params[:sampling])
		
         if line =~ /(\w+)[\t,](\w+)[\t,](\d+[-\/]\d+[-\/]\d+)[\t,](\d+)[\t,](.*?)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\w+[\D]*)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,](\S+)[\t,]([+-]*\d+)[\n\r\s]/

 #logger.debug "dan seq "+ $1 +"code "+$2+"partner_id "+$3+"people_id "+$4+"name "+$5+"oligodate "+$6+"description "+$7
			#@sampling.sampling_site_id = $1.to_s
			#@sampling.partner_id = $2.to_s
			
                        #user will enter name and code below will change it to their respective IDs
                        site_code = $1
                        @samplingsite = SamplingSite.find_by_code(site_code)
                        @sampling.sampling_site_id = @samplingsite.id
                        
                        ptr_code = $2
                        @ptnr = Partner.find_by_code(ptr_code)
                        @sampling.partner_id = @ptnr.id

                        @sampling.samplingDate = $3.to_s
			@sampling.volume = $4.to_s
			@sampling.note = $5.to_s
			@sampling.air_temperature = $6.to_s
			@sampling.moisture = $7.to_s
			@sampling.pressure = $8.to_s
			@sampling.windSpeed = $9.to_s
			@sampling.windDirection = $10.to_s                    
			@sampling.waterFlow = $11.to_s
			@sampling.lightIntensity = $12.to_s
			@sampling.rainfallEvents = $13.to_s
			@sampling.depth = $14.to_s
			@sampling.turbidity = $15.to_s
			@sampling.salinity = $16.to_s
			@sampling.tidalRange = $17.to_s
			@sampling.operators = $18.to_s
			@sampling.water_temperature = $19.to_s
			@sampling.conductivity = $20.to_s
			@sampling.phosphates = $21.to_s
			@sampling.nitrates = $22.to_s
			@sampling.ph = $23.to_s
			@sampling.nitrogen = $24.to_s
			@sampling.bod5 = $25.to_s
			@sampling.cod = $26.to_s
			@sampling.h2osat = $27.to_s
			@sampling.sampling_equipments_id = $28.to_s
			@sampling.storage = $29.to_s	     
		        		         
		   end
		 #@oligo_sequences.batch_oligo_id = @batch_oligo.id 
		 @pt = Partner.find(@sampling.partner_id)

                 @sampling.code = get_code(@pt, @sampling.samplingDate, nil)

                 @sampling.save

               end
         end

      rescue => err	
      flash.now[:error] = "Exception parse_file: #{err}..."
      #print to the console       puts "Exception: #{err}"
      logger.error "Sampling parse_file error: " + err.message  
      logger.error err.backtrace.inspect
      return false
      end  

  end


  def download_sample_sampling_csv
    
    begin
      logger.debug "::::::::::::::::::::Sample sampling download data (" + current_user.name + "):::::::::::::::::::: "

     #@sample1 = Sampling.find(1)
     #@sample2 = Sampling.find(2)

    file = FasterCSV.generate do |line|
    cols = ["Sampling Site", "Partner", "Sampling date(YYYY-MM-DD)","Volume","Comment","Air Temp. (default = 0.0)", "Moisture",
            "Pressure", "Wind Speed", "Wind Direction","Water Flow","Light Int.","Rainfall evts.", "Depth",
            "Turbidity", "Salinity", "Tidal Range","Operators","Water Temp.","Conductivity", "Phosphates",
            "Nitrates", "pH", "Nitrogen","Bod5","Cod","H2OSat", "Sampling Equip.(1=bucket, 2=pump)", "Storage(in degrees)"]
    line << cols
               
    line << [ "canet", "unicam", "2013-01-06", "4", "This is test..for sampling data file 10/10/2013 60L
", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "kumar", "0.0", "0.0", "0.0", "0.0","0.0", "0.0", "0.0", "0.0", "0.0", "1", "4" ]

    #line << [ @sample2.sampling_site_id, @sample2.partner_id, @sample2.samplingDate, @sample2.volume, @sample2.note, @sample2.air_temperature, @sample2.moisture, @sample2.pressure, @sample2.windSpeed, @sample2.windDirection, @sample2.waterFlow, @sample2.lightIntensity, @sample2.rainfallEvents, @sample2.depth, @sample2.turbidity, @sample2.salinity, @sample2.tidalRange, @sample2.operators, @sample2.water_temperature, @sample2.conductivity, @sample2.phosphates, @sample2.nitrates, @sample2.ph, @sample2.nitrogen, @sample2.bod5, @sample2.cod, @sample2.h2osat, @sample2.sampling_equipments_id, @sample2.storage ]
  

    end
    
    send_data(file, 
    :type => 'text/csv;charset=utf-8;header=present', 
    :disposition => "attachment;filename=example_sampling_data_#{Time.now.strftime('%d%m%y-%H%M')}.csv")
     


    rescue => err
      flash.now[:error] = "Exception extractFile: #{err}..."
      logger.warn("#{Time.now} - Unknown type requested: #{params.inspect}")
      #render :text => t('private_files_controller.bad_request'), :status => 400
      render :text => 'private_files_controller.unauthorized: ' + err, :status => 401
      return false
    end  
  end 



  # PUT /batch_samplings/1
  # PUT /batch_samplings/1.xml
  def update
    @batch_sampling = BatchSampling.find(params[:id])

    respond_to do |format|
      if @batch_sampling.update_attributes(params[:batch_sampling])
        format.html { redirect_to(@batch_sampling, :notice => 'BatchSampling was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @batch_sampling.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /batch_samplings/1
  # DELETE /batch_samplings/1.xml
  def destroy
    @batch_sampling = BatchSampling.find(params[:id])
    @batch_sampling.destroy

    respond_to do |format|
      format.html { redirect_to(batch_samplings_url) }
      format.xml  { head :ok }
    end
  end



 #for generating Sampling code while parsing values(Same as in sampling controller)
 def get_code(partner, pdate, ptype)
   
     @codegen = ""
  
      if partner.nil? and not signed_in_and_master?
        return "P??"
      end
  
      @pid = 1
  
      unless partner.nil?
        @pid = partner.id  
        @codegen += "P"
        @codegen += "%02d" % partner.fp7_Number
        @codegen += "-"
      
      else
      
        if signed_in_and_master?
          @codegen += "ADM"
        else
          @codegen += "P??"
        end
      
      end

      if pdate.nil?
        #only for generate sample code in the new view (but it is hide)
        pdate = Date.today
      end

      unless pdate.nil?
        
        @codegen += pdate.strftime("%y%m%d")
        @codegen += "-"
      end

      @cnt_objs = Sampling.all(:select => "DISTINCT code", :conditions => ['code LIKE ? ', '%'+@codegen+'%'], :order => 'code DESC')
      @cnt = 1 
      if not @cnt_objs.nil? 
          @cnt_obj = @cnt_objs[0] 
          if not @cnt_obj.nil? 
             #P03-110129-xx
             if not @cnt_obj.code.nil? 
                @end_str = @cnt_obj.code[11..12]
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

      unless ptype.nil?
        @codegen += ptype.to_s
      end

      return @codegen
    end



end
