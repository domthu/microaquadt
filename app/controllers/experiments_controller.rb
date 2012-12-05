class ExperimentsController < ApplicationController
  
  class UnknownTypeError < StandardError
  end

  before_filter :correct_user, :only => [:edit, :update, :delete, :destroy]

  # GET /experiments
  # GET /experiments.xml
  def index
   # @experiments = Experiment.all
   
    @title = "Microarray experiments"
  
   if params[:id].present?

         logger.warn("#{Time.now} - experiments filtered by: #{params[:id]}")  
    
        
    begin

         code_gen = OligoSequence.find_by_id(params[:id]).code
         ol = Oligo.find_all_by_code(code_gen).collect{|p| p.microarraygal_id}
       
       
      #if !ol.empty?
         experiments = Experiment.find(:all, :conditions => [ "microarraygal_id IN (?)", ol])  do       
		    
	       paginate :page => params[:page], :per_page => params[:rows]      
	       order_by "#{params[:sidx]} #{params[:sord]}"            
	    end

       rescue 
	   
          experiments = Experiment.find(:all, :conditions => [ "filter_sample_id = ?", params[:id]]) do    
          paginate :page => params[:page], :per_page => params[:rows]      
	  order_by "#{params[:sidx]} #{params[:sord]}"
            end
         end

        respond_to do |format|
        format.html 
        format.json { render :json => experiments.to_jqgrid_json([:id,"act","exp_code","gal_code","exp_date","edit"], params[:page], params[:rows], experiments.total_entries) }		
        end


    else
        experiments = Experiment.find(:all, :joins=>[:partner, :filter_sample, :microarraygal]) do
        
        if params[:_search] == "true"
           ecode =~ "%#{params[:exp_code]}%" if params[:exp_code].present?
           filter_sample.code =~ "%#{params[:filter_name]}%" if params[:filter_name].present?
           partner.code =~ "%#{params[:partner_name]}%" if params[:partner_name].present?
           microarraygal.id =~ "%#{params[:gal_code]}%" if params[:gal_code].present?
           experiment_date =~ "%#{params[:exp_date]}%" if params[:exp_date].present?
	end

        paginate :page => params[:page], :per_page => params[:rows]      
        order_by "#{params[:sidx]} #{params[:sord]}"
                  
	if params[:sidx] == "exp_code"
	   order_by "experiments.ecode #{params[:sord]}"
        elsif params[:sidx] == "filter_name"
           order_by "filter_samples.code #{params[:sord]}"
        elsif params[:sidx] == "partner_name"
           order_by "partners.code #{params[:sord]}"
        elsif params[:sidx] == "gal_code"
           order_by "microarraygals.id #{params[:sord]}"
        elsif params[:sidx] == "exp_date"
           order_by "experiment_date #{params[:sord]}"    
	end     
     end
        
        respond_to do |format|
        format.html      
        format.json { render :json => experiments.to_jqgrid_json([:id,"act","exp_code","filter_name","gal_code","partner_name","gpr_code","exp_date","edit"], params[:page], params[:rows], experiments.total_entries) }			
          end
    end
 end
 

    
  # GET /experiments/1
  # GET /experiments/1.xml
  def show
   
  @experiment = Experiment.find(params[:id])
    @title = "Microarray experiments"

  

    if @experiment.nil?
        redirect_to :action => "index"
    end
    @pt = Partner.find(@experiment.partner_id)

    @mg = Microarraygal.find(@experiment.microarraygal_id)
    if @mg.nil?
      flash.now[:error] = "No Microarray .gal file found! create some..."
      redirect_to :action => "index"
    end
     

      respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @experiment }
      format.csv { download_csv }
    end
  end


  # GET /experiments/new
  # GET /experiments/new.xml
  def new
    logger.debug "::::::::::::::::::::microarray experiment create new (" + current_user.name + "):::::::::::::::::::: "
    
    @experiment = Experiment.new
    @title = "Microarray experiments"

    @mg_c = Microarraygal.count()
    if @mg_c.nil? or @mg_c == 0
      flash[:error] = "No microarraygal found! create first someone..."
      redirect_to :action => "index"
      return
    end
  
    @partners = Partner.find(:all)
    @pt = get_partner
    if @pt.nil?
      @mg = Microarraygal.all()
      @gp = Microarraygpr.all()
      
    else
      @mg = Microarraygal.all(:conditions => [ "partner_id = ?", @pt.id])
      @gp = Microarraygpr.all(:conditions => [ "partner_id = ?", @pt.id])
      @experiment.partner_id = @pt.id
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @experiment }
    end
  end

  # GET /experiments/1/edit
  def edit
    @experiment = Experiment.find(params[:id])
    @title = "Microarray experiments"
    @code = @experiment.ecode
  end

  # POST /experiments
  # POST /experimentsxml
  def create
    logger.debug "::::::::::::::::::::microarray experiments create action (" + current_user.name + "):::::::::::::::::::: "
    
     @experiment = Experiment.new(params[:experiment])
    @title = "Microarray experiments"
     
     
    
    @valid = false
    if @experiment.partner.nil?
      flash.now[:error] = "No partner found for this microarray experiments"
      @valid = true
    end

    if @valid
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @experiment.errors, :status => :unprocessable_entity }
      end
      return 
    end

    @pt = get_partner
    @experiment.ecode = get_code(@pt, @experiment.experiment_date, nil)

    @title = "Experiment"

    respond_to do |format|
      if @experiment.save
     

        format.html { 
                    flash[:notice] = 'New experiment is successfully created (You can check the oligos, used in this experiment, by clicking on the "+" sign on individual experiments row!!!)'
                    redirect_to :action => "index"  }
        format.xml  { render :xml => @experiment, :status => :created, :location => @experiment }
      else

        #@partners = Partner.find(:all)
        @codegen = @experiment.code
        @attr_index = 1
        @pt = get_partner

        format.html { render :action => "new" }
        format.xml  { render :xml => @experiment.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /experiments/1
  # PUT /experiments/1.xml
  def update
    @experiment = Experiment.find(params[:id])
    @title = "Microarray experiments"

    respond_to do |format|
      if @experiment.update_attributes(params[:experiment])
        format.html { redirect_to(@experiment, :notice => 'Microarray experiment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @experiment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /experiments/1
  # DELETE /experiments/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to water_types_path
    else

        @experiment = Experiment.find(params[:id])
        @experiment.destroy
        @title = "Microarray experiments"

        respond_to do |format|
          format.html { redirect_to(experiments_url) }
          format.xml  { head :ok }
        end
    end
  end


  private

    def correct_user
      @ex = Experiment.find(params[:id])
      @partner = Partner.find(@ex.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash.now[:notice] = "Only the partner who created the microarray experiment can modify it."
      redirect_to(experiments_path)
    end


   def get_code(partner, pdate, ptype)
      @codegen = ""
      if partner.nil? and not signed_in_and_master?
        return "P??"
      end
      @pid = 1
      unless partner.nil?
        @pid = partner.id
        #2 digits = Nation IT
        #@codegen += partner.country.code.upcase
        #3 or 2 digits -= Partner number, P5 OR P
        @codegen += "E"
        @codegen += "%02d" % partner.fp7_Number
        @codegen += "-"
      else
        if signed_in_and_master?
          @codegen += "ADM"
        else
          @codegen += "E??"
        end
      end

      #4 or 3 = date month and years 1211 OR 121
      #2011 create increment number by registered date
      if pdate.nil?
        #only for generate sample code in the new view (but it is hide)
        pdate = Date.today
      end

      unless pdate.nil?
        #time = Time.new
        #@codegen += time.month.to_s + time.year.to_s
        @codegen += pdate.strftime("%y%m%d")
        @codegen += "-"
      end

#      #3 digit = Sample,  001
#      #@cnt = Sampling.count()
#      @cnt = Sampling.calculate(:count, :all, :conditions => ['partner_id = ' + @pid.to_s ])
#      #@lst = Sampling.last
      #2011 create increment number by registered date and partner
#      @cnt = Sampling.calculate(:count, :all, :conditions => ['partner_id =  ? AND samplingDate >= ? AND samplingDate < ? ',  @pid.to_s, Date.today, 1.day.from_now.to_date ])
#      @cnt = Sampling.calculate(:count, :all, :conditions => ['code LIKE ? ', '%'+@codegen+'%'])
      @cnt_objs = Experiment.all(:select => "DISTINCT ecode", :conditions => ['ecode LIKE ? ', '%'+@codegen+'%'], :order => 'ecode DESC')
      @cnt = 1 
      if not @cnt_objs.nil? 
          @cnt_obj = @cnt_objs[0] 
          if not @cnt_obj.nil? 
             #P03-110129-xx
             if not @cnt_obj.ecode.nil? 
                @end_str = @cnt_obj.ecode[11..12]
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

      # 1 digit organisms b (bacteria) (PTR5)
      # or 1 digit (PTR4) water tyrpe R (river) Lake etc..
      unless ptype.nil?
        @codegen += ptype.to_s
#      else
#        @codegen += "?"
      end

      return @codegen
    end

end
