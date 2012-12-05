class GprDatasController < ApplicationController

def index
	   @gpr_datas = GprData.all
           @title = "GenePix result data"

        
        gpr_datas = GprData.find(:all) do
            paginate :page => params[:page], :per_page => params[:rows]      
            order_by "#{params[:sidx]} #{params[:sord]}"
           end

         respond_to do |format|
        format.html 
        format.json { render :json => gpr_datas.to_jqgrid_json([:id,"act","gpr_code","array_info",:x,:y,
:dia,:f635_median,:f635_mean,:f635_sd,:f635_cv,:b635,:b635_Median,:b635_mean,:b635_sd,:b635_cv,
:percent_b635_1_sd,:percent_b635_2_sd,:f635_perc_sat,:f532_median,:f532_mean,:f532_sd,:f532_cv,:b532,
:b532_median,:b532_mean,:b532_sd,:b532_cv,:percent_b532_1_sd,:percent_b532_2_sd,:f532_perc_sat,
:ratio_of_medians,:ratio_of_means,:median_of_ratios,:mean_of_ratios,:ratios_sd,:rgn_ratio,:rgn_r2,
:f_pixels,:b_pixels,:circularity,:sum_of_medians,:sum_of_means,:log_ratio,:f635_median_minus_b635,
:f532_median_minus_b635,:f635_mean_minus_b635,:f532_mean_minus_b635,:f635_total_intensity,
:f532_total_intensity,:snr_635,:snr_532,:flags,:normalize,:autoflag,"edit"], params[:page], params[:rows], gpr_datas.total_entries) }			
      end      
  end



  def show
          @gpr_data = GprData.find(params[:id])

	    respond_to do |format|
	    format.html # show.html.erb
	    format.xml  { render :xml => @gpr_data }
	  end
  end

  def edit
      @gpr_data = GprData.find(params[:id])
  end

  

  def update
        @gpr_data = GprData.find(params[:id])

	    respond_to do |format|
	      if @gpr_data.update_attributes(params[:GprData])
		format.html { redirect_to(@gpr_data, :notice => 'GprData is successfully updated.') }
		format.xml  { head :ok }
	      else
		format.html { render :action => "edit" }
		format.xml  { render :xml => @gpr_data.errors, :status => :unprocessable_entity }
	      end
	    end
  end

  def destroy
      if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to gpr_datas_path
    else

        @mg = Microarraygpr.find(:first, :conditions => [ "gpr_data_id = ?", params[:id]])
        if !@mg.nil?
          flash[:error] = "This entry cannot be deleted until used by another entries in the system..."
          redirect_to :action => "index"
          return
        end

        @gpr_data = GprData.find(params[:id])
        @gpr_data.destroy

        respond_to do |format|
          format.html { redirect_to(gpr_data_url) }
          format.xml  { head :ok }
         end
      end
  end






end
