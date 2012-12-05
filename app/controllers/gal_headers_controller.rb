class GalHeadersController < ApplicationController
  

  # GET /gal_header
  # GET /gal_header.xml
  def index
    @gal_headers = GalHeader.all
    @title = "GAL file header information"
           gal_headers = GalHeader.find(:all) do

               if params[:_search] == "true"
			   microarraygal.id =~ "%#{params[:gal_id]}%" if params[:gal_id].present?
			   gal_row_count =~ "%#{params[:row_count]}%" if params[:row_count].present?
			   gal_column_count =~ "%#{params[:column_count]}%" if params[:column_count].present?
                           block_count =~ "%#{params[:bcount]}%" if params[:bcount].present?
                           block_type =~ "%#{params[:block_type]}%" if params[:block_type].present?
                           supplier =~ "%#{params[:company]}%" if params[:company].present?
			   
			end

	       paginate :page => params[:page], :per_page => params[:rows]
	       order_by "#{params[:sidx]} #{params[:sord]}" 

		       if params[:sidx] == "gal_id"
			  order_by "microarraygals.id #{params[:sord]}"
		       elsif params[:sidx] == "row_count"
			  order_by "gal_row_count #{params[:sord]}"
		       elsif params[:sidx] == "column_count"
			  order_by "gal_column_count #{params[:sord]}"
                       elsif params[:sidx] == "bcount"
			  order_by "block_count #{params[:sord]}"
                       elsif params[:sidx] == "block_type"
			  order_by "block_type #{params[:sord]}"
                       elsif params[:sidx] == ":company"
			  order_by "supplier #{params[:sord]}"    
		       end  

          end

        respond_to do |format|
        format.html 
        format.json { render :json => gal_headers.to_jqgrid_json([:id,"act","gal_id","version","row_count","column_count","bcount",:block_type,"company","header_upload_date","edit"], params[:page], params[:rows], gal_headers.total_entries) }			
    end
  end

  # GET /gal_header/1
  # GET /gal_header/1.xml
  def show
    @gal_header = GalHeader.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gal_header }
    end
  end

  # GET /gal_header/1/edit
  def edit
    @gal_header = GalHeader.find(params[:id])
  end

  # PUT /gal_header/1
  # PUT /gal_header/1.xml
  def update
    @gal_header = GalHeader.find(params[:id])

    respond_to do |format|
      if @gal_header.update_attributes(params[:gal_header])
        format.html { redirect_to(@gal_header, :notice => 'GalHeader was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gal_header.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gal_header/1
  # DELETE /gal_header/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to gal_header_path
    else

        @mg = Microarraygal.find(:first, :conditions => [ "gal_header_id = ?", params[:id]])
        if !@mg.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @gal_header = GalHeader.find(params[:id])
        @gal_header.destroy

        respond_to do |format|
          format.html { redirect_to(gal_header_url) }
          format.xml  { head :ok }
        end
    end
  end

end
