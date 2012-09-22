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
        format.json { render :json => oligos.to_jqgrid_json([:id,"act","oligo_id","oligo","edit"], params[:page], params[:rows], oligos.total_entries) }			
      end
      
    
        else
        
		oligos = Oligo.find(:all) do
		paginate :page => params[:page], :per_page => params[:rows]      
		end
		respond_to do |format|
		format.html 
		format.json { render :json => oligos.to_jqgrid_json([:id,"act","gal_o_code","array_info","oligo_id","oligo","oligo_upload_date","edit"], params[:page], params[:rows], oligos.total_entries) }			
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
