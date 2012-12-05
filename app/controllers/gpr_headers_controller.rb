class GprHeadersController < ApplicationController


def index
    @gpr_headers = GprHeader.all
    @title = "GPR file header information"
           gpr_headers = GprHeader.find(:all) do

              # if params[:_search] == "true"
		#	   microarraygpr.id =~ "%#{params[:gal_id]}%" if params[:gal_id].present?
		#	   gal_row_count =~ "%#{params[:row_count]}%" if params[:row_count].present?
		#	   gal_column_count =~ "%#{params[:column_count]}%" if params[:column_count].present?
                 #          block_count =~ "%#{params[:bcount]}%" if params[:bcount].present?
                  #         block_type =~ "%#{params[:block_type]}%" if params[:block_type].present?
                   #        supplier =~ "%#{params[:company]}%" if params[:company].present?
			   
		#	end

	       paginate :page => params[:page], :per_page => params[:rows]
	       order_by "#{params[:sidx]} #{params[:sord]}" 

		 #      if params[:sidx] == "gal_id"
		#	  order_by "microarraygals.id #{params[:sord]}"
		 #	  order_by "gal_row_count #{params[:sord]}"
		  #     elsif params[:sidx] == "column_count"
		#	  order_by "gal_column_count #{params[:sord]}"
                 #      elsif params[:sidx] == "bcount"
		#	  order_by "block_count #{params[:sord]}"
                 #      elsif params[:sidx] == "block_type"
		#	  order_by "block_type #{params[:sord]}"
                 #      elsif params[:sidx] == ":company"
		#	  order_by "supplier #{params[:sord]}"    
		 #      end  

          end

        respond_to do |format|
        format.html 
        format.json { render :json => gpr_headers.to_jqgrid_json([:id,"act",:microarraygpr_id,:gprVersion,:gprtype,:datetime,:settings,:pixelsize,:wavelengths, 
:normalizationmethod,:normalizationfactors, :stddev, :ratioformulations,:featuretype, :barcode, :backgroundsubtraction, 
:imageorigin, :jpegorigin, :creator, :scanner, :focusposition, :temp, :linesavg, :comment, :pmtgain, 
:scanpower, :laserpower, :filters, :scanregion, :supplier, :created_at, "edit"], params[:page], params[:rows], gpr_headers.total_entries) }			
    end
  end



# GET /gpr_header/1
  # GET /gpr_header/1.xml
  def show
    @gpr_header = GprHeader.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gpr_header }
    end
  end

  # GET /gpr_header/1/edit
  def edit
    @gpr_header = GprHeader.find(params[:id])
  end

  # PUT /gpr_header/1
  # PUT /gpr_header/1.xml
  def update
    @gpr_header = GprHeader.find(params[:id])

    respond_to do |format|
      if @gpr_header.update_attributes(params[:gpr_header])
        format.html { redirect_to(@gpr_header, :notice => 'GprHeader is successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gpr_header.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gpr_header/1
  # DELETE /gpr_header/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to gpr_header_path
    else

        @mg = Microarraygpr.find(:first, :conditions => [ "gpr_header_id = ?", params[:id]])
        if !@mg.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @gpr_header = GprHeader.find(params[:id])
        @gpr_header.destroy

        respond_to do |format|
          format.html { redirect_to(gpr_header_url) }
          format.xml  { head :ok }
        end
    end
  end
















end
