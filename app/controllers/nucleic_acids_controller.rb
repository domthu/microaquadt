class NucleicAcidsController < AuthController  #ApplicationController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update, :delete]

  # GET /nucleic_acids  
  # GET /nucleic_acids.xml
  def index
    @title = "nucleic acids"
    @nucleic_acids = NucleicAcid.all

    nucleic_acids = NucleicAcid.find(:all, :joins => [:nucleic_acid_type, :filter_sample, :partner]) do
        if params[:_search] == "true"
            code =~ "%#{params[:code]}%" if params[:code].present?
            #filter_sample.barcode =~ "%#{params[:filter_sample_name]}%" if params[:filter_sample_name].present?
            filter_sample.code =~ "%#{params[:filter_sample_name]}%" if params[:filter_sample_name].present?
            nucleic_acid_type.name =~ "%#{params[:nucleic_acid_type_name]}%" if params[:nucleic_acid_type_name].present?
#Mysql::Error: Not unique table/alias: 'filter_samples': SELECT `nucleic_acids`.`id` AS t0_r0, `nucleic_acids`.`filter_sample_id` AS t0_r1, `nucleic_acids`.`nucleic_acid_type_id` AS t0_r2, `nucleic_acids`.`date` AS t0_r3, `nucleic_acids`.`partner_id` AS t0_r4, `nucleic_acids`.`code` AS t0_r5, `nucleic_acids`.`description` AS t0_r6, `nucleic_acids`.`created_at` AS t0_r7, `nucleic_acids`.`updated_at` AS t0_r8, `filter_samples`.`id` AS t1_r0, `filter_samples`.`sampling_id` AS t1_r1, `filter_samples`.`samplingDate` AS t1_r2, `filter_samples`.`wfilter_id` AS t1_r3, `filter_samples`.`pore_size` AS t1_r4, `filter_samples`.`num_filters` AS t1_r5, `filter_samples`.`avg_qta` AS t1_r6, `filter_samples`.`volume` AS t1_r7, `filter_samples`.`barcode` AS t1_r8, `filter_samples`.`code` AS t1_r9, `filter_samples`.`note` AS t1_r10, `filter_samples`.`created_at` AS t1_r11, `filter_samples`.`updated_at` AS t1_r12, `filter_samples`.`storage` AS t1_r13, `filter_samples`.`filter_sample_preparations_id` AS t1_r14, `samplings`.`id` AS t2_r0, `samplings`.`code` AS t2_r1, `samplings`.`volume` AS t2_r2, `samplings`.`sampling_site_id` AS t2_r3, `samplings`.`partner_id` AS t2_r4, `samplings`.`samplingDate` AS t2_r5, `samplings`.`note` AS t2_r6, `samplings`.`air_temperature` AS t2_r7, `samplings`.`moisture` AS t2_r8, `samplings`.`pressure` AS t2_r9, `samplings`.`windSpeed` AS t2_r10, `samplings`.`windDirection` AS t2_r11, `samplings`.`waterFlow` AS t2_r12, `samplings`.`lightIntensity` AS t2_r13, `samplings`.`rainfallEvents` AS t2_r14, `samplings`.`depth` AS t2_r15, `samplings`.`turbidity` AS t2_r16, `samplings`.`salinity` AS t2_r17, `samplings`.`tidalRange` AS t2_r18, `samplings`.`operators` AS t2_r19, `samplings`.`water_temperature` AS t2_r20, `samplings`.`conductivity` AS t2_r21, `samplings`.`phosphates` AS t2_r22, `samplings`.`nitrates` AS t2_r23, `samplings`.`ph` AS t2_r24, `samplings`.`nitrogen` AS t2_r25, `samplings`.`bod5` AS t2_r26, `samplings`.`cod` AS t2_r27, `samplings`.`h2osat` AS t2_r28, `samplings`.`created_at` AS t2_r29, `samplings`.`updated_at` AS t2_r30, `samplings`.`sampling_equipments_id` AS t2_r31, `samplings`.`storage` AS t2_r32 FROM `nucleic_acids`  LEFT OUTER JOIN `filter_samples` ON `filter_samples`.id = `nucleic_acids`.filter_sample_id  LEFT OUTER JOIN `samplings` ON `samplings`.id = `filter_samples`.sampling_id   INNER JOIN `nucleic_acid_types` ON `nucleic_acid_types`.id = `nucleic_acids`.nucleic_acid_type_id  INNER JOIN `filter_samples` ON `filter_samples`.id = `nucleic_acids`.filter_sample_id  INNER JOIN `partners` ON `partners`.id = `nucleic_acids`.partner_id  WHERE ((((samplings.code LIKE '%a%'))))  LIMIT 0, 50
            filter_sample.sampling.volume =~ "%#{params[:sampling_name]}%" if params[:sampling_name].present?
            partner.code =~ "%#{params[:partner_name]}%" if params[:partner_name].present?
            partner.code =~ "%#{params[:partner_name]}%" if params[:partner_name].present?
            date =~ "%#{params[:date]}%" if params[:date].present?
        end
        paginate :page => params[:page], :per_page => params[:rows]      
        if params[:sidx] == "partner_name"
            order_by "partner_id #{params[:sord]}"
        elsif params[:sidx] == "sampling_name"
            order_by "filter_sample_id #{params[:sord]}"
        elsif params[:sidx] == "filter_sample_name"
            order_by "filter_sample_id #{params[:sord]}"
        elsif params[:sidx] == "nucleic_acid_type_name"
            order_by "nucleic_acid_type_id #{params[:sord]}"
        else
            order_by "#{params[:sidx]} #{params[:sord]}"
        end
    end

    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @nucleic_acids }
      format.json { render :json => nucleic_acids.to_jqgrid_json(
            [:id, "act", :code,"sampling_name","filter_sample_name",:nucleic_acid_type_name, "partner_name",:date, "edit"],
            params[:page], params[:rows], nucleic_acids.total_entries) }		
    end

  end

  # GET /nucleic_acids/1
  # GET /nucleic_acids/1.xml
  def show
    @title = "nucleic acid"
    @nucleic_acid = NucleicAcid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nucleic_acid }
    end
  end

  # GET /nucleic_acids/new
  # GET /nucleic_acids/new.xml
  def new
    @title = "nucleic acid"
    @nucleic_acid = NucleicAcid.new

    @pt = get_partner
#    @fs = FilterSample.find(params[:id], :include => {:samplings, :partners})
#    @comments = @fs.samplings.map{|u| u.partners}.flatten
    if @pt.nil?
      @fs = FilterSample.all()
    else
#      @fs = FilterSample.find :all, :joins => [:samplings, :partners], :conditions => ["decks.game_id = ? and cards.present = ?", @game.id, true]
      @fs = FilterSample.find :all, :joins => [:sampling], :conditions => ["partner_id = ?", @pt.id]
      #@fs = FilterSample.all(:conditions => [ "partner_id = ?", @pt.id])
    end
#<%= select :nucleic_acid,:filter_sample_id, FilterSample.all.collect{|p| [p.verbose_me, p.id]}%>
#<%= select :nucleic_acid,:filter_sample_id, @fs.collect{|p| [p.verbose_me, p.id]}%>
    if @fs.nil? or @fs.count <=0
        #flash.now[:error] = "No filter sample found for you. You must first create some before inserting nucleic acid"
        flash[:error] = "No filter sample found for you. You must first create some before inserting nucleic acid..."
        #redirect_to :action => "index"
        redirect_to(filter_samples_url)
        #redirect_to(nucleic_acids_url)
        #redirect_to :action => "index"
        return 
    end
    #@nat = NucleicAcidType.all()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nucleic_acid }
    end
  end
#<table>
#  <tr>
#    <th>Code</th>
#    <th>Filter sample</th>
#    <th>Nucleic acid type</th>
#    <th>Date</th>
#    <th>Partner</th>
#    <th>Description</th>
#  </tr>

#<% @nucleic_acids.each do |nucleic_acid| %>
#  <tr>
#    <td><%=h nucleic_acid.code %></td>
#    <td><%=h nucleic_acid.code %></td>
#    <td><%=h nucleic_acid.nucleic_acid_type %></td>
#    <td><%=h nucleic_acid.date %></td>
#    <td><%=h nucleic_acid.partner %></td>
#    <td><%=h nucleic_acid.description %></td>
#    <td><%= link_to 'Show', nucleic_acid %></td>
#    <td><%= link_to 'Edit', edit_nucleic_acid_path(nucleic_acid) %></td>
#    <td><%= link_to 'Delete', nucleic_acid, :confirm => 'Are you sure?', :method => :delete %></td>
#  </tr>
#<% end %>
#</table>

  # GET /nucleic_acids/1/edit
  def edit
    @title = "nucleic acid"
    @nucleic_acid = NucleicAcid.find(params[:id])

    #@fs = FilterSample.find(@nucleic_acid.filter_sample)
    #@partner = Partner.find(@nucleic_acid.partner)
    @nat = NucleicAcid.all()

  end

  # POST /nucleic_acids
  # POST /nucleic_acids.xml
  def create
    @title = "nucleic acid"
    @nucleic_acid = NucleicAcid.new(params[:nucleic_acid])

    @valid = false
    if @nucleic_acid.filter_sample.nil?
      flash.now[:error] = "No filter sample set for this nucleic acid"
      @valid = true
    else
        @nucleic_acid.partner = @nucleic_acid.filter_sample.sampling.partner
    end
    if @nucleic_acid.partner.nil?
      flash.now[:error] = "No partner found for this nucleic acid"
      @valid = true
    end

    if @valid
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @nucleic_acid.errors, :status => :unprocessable_entity }
      end
    end

    respond_to do |format|
      if @nucleic_acid.save
        format.html { redirect_to(@nucleic_acid, :notice => 'NucleicAcid was successfully created.') }
        format.xml  { render :xml => @nucleic_acid, :status => :created, :location => @nucleic_acid }
      else

        @pt = get_partner
        if @pt.nil?
          @fs = FilterSample.all()
        else
          @fs = FilterSample.find :all, :joins => [:sampling], :conditions => ["partner_id = ?", @pt.id]
        end

        format.html { render :action => "new" }
        format.xml  { render :xml => @nucleic_acid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nucleic_acids/1
  # PUT /nucleic_acids/1.xml
  def update
    @title = "nucleic acid"
    @nucleic_acid = NucleicAcid.find(params[:id])

    respond_to do |format|
      if @nucleic_acid.update_attributes(params[:nucleic_acid])
        format.html { redirect_to(@nucleic_acid, :notice => 'NucleicAcid was successfully updated.') }
        format.xml  { head :ok }
      else

        #@fs = FilterSample.find(@nucleic_acid.filter_sample)
        #@partner = Partner.find(@nucleic_acid.partner)
        #@nat = NucleicAcid.all()  --> KAPPAO trasforma .id in Index

        format.html { render :action => "edit" }
        format.xml  { render :xml => @nucleic_acid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nucleic_acids/1
  # DELETE /nucleic_acids/1.xml
  def destroy
    @title = "nucleic acid"
    @nucleic_acid = NucleicAcid.find(params[:id])
    @nucleic_acid.destroy

    respond_to do |format|
      format.html { redirect_to(nucleic_acids_url) }
      format.xml  { head :ok }
    end
  end


  private

    def correct_user
      @nucleic_acid = NucleicAcid.find(params[:id])
      @partner = Partner.find(@nucleic_acid.partner_id)
      @user = User.find(@partner.user_id)
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the Nucleic acid can modify it."
      redirect_to(nucleic_acids_path)
    end

end
