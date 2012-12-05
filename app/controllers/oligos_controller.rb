class OligosController < ApplicationController
  
  def index
	   @oligos = Oligo.all
           @title = "List of oligos in GAL file"

        if params[:id].present?
        logger.warn("#{Time.now} - oligo filtered by: #{params[:id]}")
        
        oligos = Oligo.find(:all, :conditions => [ "microarraygal_id = ?", params[:id]]) do
            paginate :page => params[:page], :per_page => params[:rows]      
            order_by "#{params[:sidx]} #{params[:sord]}"
           end

         respond_to do |format|
        format.html 
        format.json { render :json => oligos.to_jqgrid_json([:id,"act","oligo","edit"], params[:page], params[:rows], oligos.total_entries) }			
      end
      
    
        else
        
	  oligos = Oligo.find(:all) do

			if params[:_search] == "true"
			   microarraygal.id =~ "%#{params[:gal_o_code]}%" if params[:gal_o_code].present?
			   #oligo_sequence.id =~ "%#{params[:oligo_id]}%" if params[:oligo_id].present?
			   oligo_sequence.code =~ "%#{params[:oligo]}%" if params[:oligo].present?
			   
			end

	       paginate :page => params[:page], :per_page => params[:rows]
	       order_by "#{params[:sidx]} #{params[:sord]}" 

		       if params[:sidx] == "gal_o_code"
			  order_by "microarraygals.id #{params[:sord]}"
		      # elsif params[:sidx] == "oligo_id"
			  #order_by "oligo_sequences.id #{params[:sord]}"
		       elsif params[:sidx] == "oligo"
			  order_by "oligo_sequences.code #{params[:sord]}"    
		       end  
     
       end
		respond_to do |format|
		format.html 
		format.json { render :json => oligos.to_jqgrid_json([:id,"act","gal_o_code","array_info","oligo","oligo_upload_date","edit"], params[:page], params[:rows], oligos.total_entries) }			
	      end
    end       
  end

  def show
          @oligo = Oligo.find(params[:id])

	    respond_to do |format|
	    format.html # show.html.erb
	    format.xml  { render :xml => @oligo }
	  end
  end

  def edit
      @oligo = Oligo.find(params[:id])
  end

  def update
        @oligo = Oligo.find(params[:id])

	    respond_to do |format|
	      if @oligo.update_attributes(params[:oligo])
		format.html { redirect_to(@oligo, :notice => 'Oligos was successfully updated.') }
		format.xml  { head :ok }
	      else
		format.html { render :action => "edit" }
		format.xml  { render :xml => @oligo.errors, :status => :unprocessable_entity }
	      end
	    end
  end

  def destroy
      if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to oligos_path
    else

        @mg = Microarraygal.find(:first, :conditions => [ "oligo_id = ?", params[:id]])
        if !@mg.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @oligo = Oligo.find(params[:id])
        @oligo.destroy

        respond_to do |format|
          format.html { redirect_to(oligo_url) }
          format.xml  { head :ok }
         end
      end
  end

end
