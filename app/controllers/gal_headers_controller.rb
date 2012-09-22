class GalHeadersController < ApplicationController
  

  # GET /gal_header
  # GET /gal_header.xml
  def index
    @gal_headers = GalHeader.all
    @title = "GAL file header information"
           gal_headers = GalHeader.find(:all) do
           paginate :page => params[:page], :per_page => params[:rows]      
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
