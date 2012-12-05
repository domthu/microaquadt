class GalBlocksController < ApplicationController
  

  def index
	    @gal_blocks = GalBlock.all
            @title = "GAL file blocks information"
           gal_blocks = GalBlock.find(:all) do
           
          if params[:_search] == "true"
	     microarraygal.id =~ "%#{params[:gal_id]}%" if params[:gal_id].present?
	  end

	       paginate :page => params[:page], :per_page => params[:rows]
	       order_by "#{params[:sidx]} #{params[:sord]}" 

          if params[:sidx] == "gal_id"
	     order_by "microarraygals.id #{params[:sord]}"   
          end  

      
          end

        respond_to do |format|
        format.html 
        format.json { render :json => gal_blocks.to_jqgrid_json([:id,"act","gal_id","block","x_origin","y_origin","featureDiameter","x_feature","x_spacing","y_feature","y_spacing","block_upload_date","edit"], params[:page], params[:rows], gal_blocks.total_entries) }			
    end
  end

  def show
	   @gal_block = GalBlock.find(params[:id])

	    respond_to do |format|
	    format.html # show.html.erb
	    format.xml  { render :xml => @gal_block }
	  end
  end

  def edit
            @gal_block = GalBlock.find(params[:id])
  end

  def update
	    @gal_block = GalBlock.find(params[:id])

	    respond_to do |format|
	      if @gal_block.update_attributes(params[:gal_block])
		format.html { redirect_to(@gal_block, :notice => 'GalBlock was successfully updated.') }
		format.xml  { head :ok }
	      else
		format.html { render :action => "edit" }
		format.xml  { render :xml => @gal_block.errors, :status => :unprocessable_entity }
	      end
	    end
  end


  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to gal_blocks_path
    else

        @mg = Microarraygal.find(:first, :conditions => [ "gal_block_id = ?", params[:id]])
        if !@mg.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @gal_block = GalBlock.find(params[:id])
        @gal_block.destroy

        respond_to do |format|
          format.html { redirect_to(gal_block_url) }
          format.xml  { head :ok }
        end
    end
  end

end
