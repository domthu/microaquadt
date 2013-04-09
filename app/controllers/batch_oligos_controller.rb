class BatchOligosController < ApplicationController
 
class UnknownTypeError < StandardError
end


  # GET /batch_oligos
  # GET /batch_oligos.xml
  def index
    @batch_oligos = BatchOligo.all
    @title = "Batch upload of Oligo Sequence"

   if !signed_in?
	      flash.now[:notice] = "No Partner found!! Login with authenticated partner credentials!!!"
	      redirect_to(oligo_sequences_path)
   else

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @batch_oligos }
      end
   end
  end

  # GET /batch_oligos/1
  # GET /batch_oligos/1.xml
  def show
    @batch_oligo = BatchOligo.find(params[:id])
    @title = "Batch upload of Oligo Sequence"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @batch_oligo }
    end
  end

  # GET /batch_oligos/new
  # GET /batch_oligos/new.xml
  def new
    @batch_oligo = BatchOligo.new
    @title = "Batch upload of Oligo Sequence"

    if !signed_in?
	      flash.now[:notice] = "No Partner found!! Login with authenticated partner credentials!!!"
	      redirect_to(oligo_sequences_path)
    else

    10.times {@batch_oligo.assets.build}

    respond_to do |format|
	      format.html # new.html.erb
	      format.xml  { render :xml => @batch_oligo }
	 end
    end
  end

  # GET /batch_oligos/1/edit
  def edit
    @batch_oligo = BatchOligo.find(params[:id])
    @title = "Batch upload of Oligo Sequence"
  end

  # POST /batch_oligos
  # POST /batch_oligos.xml
  def create
    @batch_oligo = BatchOligo.new(params[:batch_oligo])
    @title = "Batch upload of Oligo Sequence"


    respond_to do |format|
      if @batch_oligo.save
         id = @batch_oligo.id
         self.parse_oligo_sequences(id)
       
        format.html { 
              flash[:notice] = 'Files have been successfully saved and new oligo sequence entries are created!!'
              redirect_to :controller => "oligo_sequences", :action => "index" }

        format.xml  { render :xml => @batch_oligo, :status => :created, :location => @batch_oligo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @batch_oligo.errors, :status => :unprocessable_entity }
      end
    end
  end



 def parse_oligo_sequences(id)
 
   begin
      logger.debug "::::::::::::::::::::Oligo Sequence parse data (" + current_user.name +  "):::::::::::::::::::: "

      if @batch_oligo.id.to_s == "" 
        logger.debug "Oligo Sequence file not saved on database. Block parsing aborted"  
        return false
      end

      
      #logger.debug "Oligo Sequence file parse for id " + @batch_oligo.assets.find([:id]).id.to_s

      
      @batch_oligos = BatchOligo.find(id)

      if @batch_oligos.assets.length > 1
      
          @batch_oligos.assets.each do |index|
     
		  file_name = index.fiolse_file_name
		  directory = "/home/kumar/microaquadt/public/fiolses/"
		       path = File.join(directory, file_name)
		       str = IO.read(path)
		       line = str.to_str	       
                  #if line =~ /\w+\s\w+[\t,][\S]+[\t,]\w+[\t,].*?[\t,]\d+-\d+-\d+[\t,]\d[\t,]\d+[\r\n]/m
                 data = line.scan(/(\w+[\t,]\S+[\t,]\w+[\t,]\w+[\t,]\w+[\s\w+]*[\t,]\d+[-\/]\d+[-\/]\d+[\t,].*?[\r\s\n])/).flatten	          
                   #logger.debug "Data array " + data.to_s
                   #$1.each do |line|	
                   data.each do |line|		   
		   #@oligo_sequences = OligoSequence.create!(params[:oligo_sequences])
                   @oligo_sequence = OligoSequence.new(params[:oligo_sequence])
		
		  if line =~ /(\w+)[\t,](\S+)[\t,](\w+)[\t,](\w+)[\t,](\w+[\s\w+]*)[\t,](\d+[-\/]\d+[-\/]\d+)[\t,](.*?)[\r\s\n]/

 #logger.debug "dan seq "+ $1 +"code "+$2+"partner_id "+$3+"people_id "+$4+"name "+$5+"oligodate "+$6+"description "+$7
    
		        @oligo_sequence.dna_sequence = $1.to_s 
                        @oligo_sequence.code = $2.to_s

                        #user will enter name and code below will change it to their respective IDs
                        ptnr_code = $3
                        @ptnr = Partner.find_by_code(ptnr_code)
                        @oligo_sequence.partner_id = @ptnr.id
                        #@oligo_sequence.partner_id = $3.to_s

		        ppl_code = $4
                        @ppl = Person.find_by_firstname(ppl_code)
                        @oligo_sequence.people_id = @ppl.id
                        #@oligo_sequence.people_id = $4.to_s

                        @oligo_sequence.name = $5.to_s
                        @oligo_sequence.oligoDate = $6.to_s 		  
		        @oligo_sequence.description = $7.to_s		     
		        		         
		     end
		 #@oligo_sequences.batch_oligo_id = @batch_oligo.id 
		 
		 @oligo_sequence.save
               end
            end

        else 
                
              file_name = @batch_oligos.assets.first.fiolse_file_name
              directory = "/home/kumar/microaquadt/public/fiolses/"
		       path = File.join(directory, file_name)
		       str = IO.read(path)
		       line = str.to_str	       
                  #if line =~ /\w+\s\w+[\t,][\S]+[\t,]\w+[\t,].*?[\t,]\d+-\d+-\d+[\t,]\d[\t,]\d+[\r\n]/m
            data = line.scan(/(\w+[\t,]\S+[\t,]\w+[\t,]\w+[\t,]\w+[\s\w+]*[\t,]\d+[-\/]\d+[-\/]\d+[\t,].*?[\r\s\n])/).flatten	          
                   #logger.debug "Data array " + data.to_s
                   #$1.each do |line|	
                   data.each do |line|		   
		   #@oligo_sequences = OligoSequence.create!(params[:oligo_sequences])
                   @oligo_sequence = OligoSequence.new(params[:oligo_sequence])
		
if line =~ /(\w+)[\t,](\S+)[\t,](\w+)[\t,](\w+)[\t,](\w+[\s\w+]*)[\t,](\d+[-\/]\d+[-\/]\d+)[\t,](.*?)[\r\s\n]/

 #logger.debug "dan seq "+ $1 +"code "+$2+"partner_id "+$3+"people_id "+$4+"name "+$5+"oligodate "+$6+"description "+$7
    
		        @oligo_sequence.dna_sequence = $1.to_s 
                        @oligo_sequence.code = $2.to_s
                       
                       #user will enter name and code below will change it to their respective IDs
                        ptnr_code = $3
                        @ptnr = Partner.find_by_code(ptnr_code)
                        @oligo_sequence.partner_id = @ptnr.id
                        #@oligo_sequence.partner_id = $3.to_s

		        ppl_code = $4
                        @ppl = Person.find_by_firstname(ppl_code)
                        @oligo_sequence.people_id = @ppl.id
                        #@oligo_sequence.people_id = $4.to_s

                        @oligo_sequence.name = $5.to_s
                        @oligo_sequence.oligoDate = $6.to_s 		  
		        @oligo_sequence.description = $7.to_s		     
		        		         
		   end
		 #@oligo_sequences.batch_oligo_id = @batch_oligo.id 
		 
		 @oligo_sequence.save
               end
         end

      rescue => err	
      flash.now[:error] = "Exception parse_file: #{err}..."
      #print to the console       puts "Exception: #{err}"
      logger.error "oligo sequence parse_file error: " + err.message  
      logger.error err.backtrace.inspect
      return false
      end
 end

 def download_sample_csv
    begin
      logger.debug "::::::::::::::::::::Sample Oligo download data (" + current_user.name + "):::::::::::::::::::: "

     #@oligo1 = OligoSequence.find(1)
     #@oligo2 = OligoSequence.find(2)

    file = FasterCSV.generate do |line|
    cols = ["DNASequence", "Code", "Partner(refer to manual)","Person(refer to manual)","Name","Date(YYYY-MM-DD)", "Description"]
    line << cols
                   
    line << [ "TTTTTTTTTTTTTTTTTT", "Axx_Cxx_Pxx", "unicam", "roberto", "Amphora Coeff.", "2013-03-01", "This is test" ]

    #line << [ @oligo2.dna_sequence, @oligo2.code, @oligo2.partner_id, @oligo2.people_id, @oligo2.name, @oligo2.oligoDate, @oligo2.description ]
        

    end
    
    send_data(file, 
    :type => 'text/csv;charset=utf-8;header=present', 
    :disposition => "attachment;filename=Sample_Oligo_data_#{Time.now.strftime('%d%m%y-%H%M')}.csv")
     


    rescue => err
      flash.now[:error] = "Exception extractFile: #{err}..."
      logger.warn("#{Time.now} - Unknown type requested: #{params.inspect}")
      #render :text => t('private_files_controller.bad_request'), :status => 400
      render :text => 'private_files_controller.unauthorized: ' + err, :status => 401
      return false
    end  
  end 


  # PUT /batch_oligos/1
  # PUT /batch_oligos/1.xml
  def update
    @batch_oligo = BatchOligo.find(params[:id])
    @title = "Batch upload of Oligo Sequence"

    respond_to do |format|
      if @batch_oligo.update_attributes(params[:batch_oligo])
        format.html { redirect_to(@batch_oligo, :notice => 'BatchOligo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @batch_oligo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /batch_oligos/1
  # DELETE /batch_oligos/1.xml
  def destroy
    @batch_oligo = BatchOligo.find(params[:id])
    @batch_oligo.destroy

    respond_to do |format|
      format.html { redirect_to(batch_oligos_url) }
      format.xml  { head :ok }
    end
  end
end
