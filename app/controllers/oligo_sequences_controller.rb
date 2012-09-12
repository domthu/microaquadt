class OligoSequencesController < AuthController   #ApplicationController

require "fastercsv"

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update, :delete, :destroy]

  # remote_function AJAX CALL 
  #Ko http://apidock.com/rails/v2.3.8/ActionView/Helpers/PrototypeHelper/remote_function prototype function
  #add to route map.connect 'lookup', :controller => 'oligo_sequences', :action => 'lookup'

  def esearch()
    logger.debug('esearch here')
    xsearch = params[:es]
    if !xsearch.nil?
        if !xsearch.include?('[Subtree]')
            xsearch = xsearch + '[Subtree]'
        end
        begin
            @esearch2 = Bio::NCBI::REST::ESearch.taxonomy(xsearch, 'xml')
            #<pre id="preName"><%= @esearch2 %></pre><br />
            #<%= @esearch2 %>
            respond_to do |format|
                format.xml  { render :xml => @esearch2 }      
            end
        rescue Exception => e
            @esearch2 = Bio::NCBI::REST::ESearch.taxonomy(xsearch)
            respond_to do |format|
                format.json  { render :json => @esearch2 }       
            end
        end 
    end       
  end

  def lookup()
    logger.debug('lookup here')
    xsearch = params[:st]
    if !xsearch.nil?
#onclick="<%= remote_function(
#                           :update => "resbio" ,
#                           :url => { :action => :lookup } , 
#                           :with => "'st='+$('search_tax').value"
#                        ); 
#        %>"

        #@filo =  Bio::PhyloXML::Parser.
        #iSearch = Integer(xsearch)
        #@tree =  Bio::NCBI::REST::EFetch.taxonomy(xsearch)
        @tree2 =  Bio::NCBI::REST::EFetch.taxonomy(xsearch, 'xml')
        
        #ParsedAndSerialized_HTML = xmlparser.new(@tree2)
        respond_to do |format|
            #format.json  { render :json => ParsedAndSerialized_HTML }      
            format.xml  { render :xml => @tree2 }      

            #In libxml2-ruby, I think LibXML::XML::Reader is the best choice,
            #because it is memory efficient than DOM and its API is simpler
            #than that of SAX. LibXML::XML::SAXParser is not bad, but I wonder
            #if the SAX's callback based API makes our codes too complex and
            #difficult to maintain.

#        render :update do |page|
          #page.replace_html 'resbio', 'Done2! --> ' + xsearch 
#          page.replace_html 'resbio', @tree 
#          page.replace_html 'resbio2', @tree2 
        end
    else
        ysearch = params[:id]
        if !xsearch.nil?
            respond_to do |format|
                #format.json  { render :json => @tree }      
                format.xml  { render :xml => @tree }      
            end
        end
    end
  end

#Cascading Drop Down Also called Related Drop Down fields or Dependant Drop Down lists or Dynamic Drop Downs or Dependent Drop Downs.
#    def for_sectionid
#        #you need to sanitize the variables being passed as a parameter
#        @subsections = SubSection.find( :all, :conditions => [" section_id = ?", params[:id]]  ).sort_by{ |k| k['name'] }    
#        @subsection = SubSection.find_all_by_section_id( params[:id]).sort_by{ |k| k['name'] }


#        respond_to do |format|
#            format.json  { render :json => @subsections }      
#        end
#    end

  # GET /oligo_sequences
  # GET /oligo_sequences.xml
  def index
    @oligo_sequences = OligoSequence.all
    @title = "List of oligo sequences"
    
# if params[:id].present?
 #  logger.warn("#{Time.now} - oligo_sequence filtered by: #{params[:id]}")
        #@filter_samples = FilterSample.all(:conditions => [ "sampling_id = ?", params[:id]])
        #@cond = params[:id]
 # oligo_sequences = OligoSequence.find(:all, :conditions => [ "experiment_id = ?", params[:id]]) do
#            if params[:_search] == "true"
#                xsample_name =~ "%#{params[:sample_name]}%" if params[:sample_name].present?
#                code =~ "%#{params[:code]}%" if params[:code].present?
#                #xfilter_name >= "%#{params[:filter_name]}%" if params[:filter_name].present?
#                pore_size >= "%#{params[:filter_name]}%" if params[:filter_name].present?
#                volume =~ "%#{params[:volume]}%" if params[:volume].present?
#                num_filters =~ "%#{params[:num_filters]}%" if params[:num_filters].present?
#            end
  #          paginate :page => params[:page], :per_page => params[:rows]      
   #         order_by "#{params[:sidx]} #{params[:sord]}"
    #    end
    #else

    _str = ""
    oligo_sequences = OligoSequence.find(:all) do
        if params[:_search] == "true"
            name =~ "%#{params[:verbose_me]}%" if params[:verbose_me].present?
#            verbose_me =~ "%#{params[:verbose_me]}%" if params[:verbose_me].present?
            dna_sequence =~ "%#{params[:dna_ellipsis]}%" if params[:dna_ellipsis].present?
#            dna_ellipsis =~ "%#{params[:dna_ellipsis]}%" if params[:dna_ellipsis].present?
            code =~ "%#{params[:code]}%" if params[:code].present?
            taxonomy_name =~ "%#{params[:taxonomy_name]}%" if params[:taxonomy_name].present?
#            taxonomy_name =~ "%#{params[:taxo_name_id]}%" if params[:taxo_name_id].present?
            taxonomy_id =~ "%#{params[:taxonomy_id]}%" if params[:taxonomy_id].present?
            if params[:available].present?
                _str = params[:available].strip.downcase                
                if _str == "true" or _str == "1"
                    available = "true"
                else
                    available = "false"
                end
            end    
            partner.code =~ "%#{params[:partner_name]}%" if params[:partner_name].present?
            people.firstname =~ "%#{params[:people_name]}%" if params[:people_name].present?
        end
        paginate :page => params[:page], :per_page => params[:rows]      
        
        if params[:sidx] == "oligo_exp_code"
            order_by "oligo_sequences.oligo_exp_code #{params[:sord]}"

        elsif params[:sidx] == "verbose_me"
            order_by "oligo_sequences.name #{params[:sord]}"
        elsif params[:sidx] == "dna_ellipsis"
            order_by "dna_sequence #{params[:sord]}"
        #After set join conditions we fall in Mysql::Error: Column 'volume' in order clause is ambiguous
        #set the database table name and column
        elsif params[:sidx] == "code"
            order_by "oligo_sequences.code #{params[:sord]}"
        elsif params[:sidx] == "partner_name"
            order_by "partners.code #{params[:sord]}"
        elsif params[:sidx] == "people_name"
            order_by "peoples.firstname #{params[:sord]}, people.lastname #{params[:sord]}"
        elsif params[:sidx] == "gCode"
            order_by "oligo_sequences.galCode #{params[:sord]}"
        else
            order_by "#{params[:sidx]} #{params[:sord]}"
        end
      end

    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @oligo_sequences }
      format.csv { render @oligo_sequences.to_csv }
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
      format.json { render :json => oligo_sequences.to_jqgrid_json(
            [:id, "act",:code,"verbose_me", "dna_ellipsis", "partner_name", "people_name", "oligo_exp_code", :taxonomy_name, :taxonomy_id,"gCode", :available,"edit"],
            params[:page], params[:rows], oligo_sequences.total_entries) }			
#The order of the fields in the first parameter matters, it should be the same than the display order in your datagrid. 
#            "verbose_me","dna_ellipsis",:name,:dna_sequence
#            [:id, "act", :code,"verbose_me", "dna_ellipsis", "partner_name", "people_name", "taxo_name_id", :available, "edit"],
    end
  end

#, :searchtype => "select", :searchoptions => { :data => [Partner.all, :id, :verbose_me] } },
#, :searchtype => "select", :searchoptions => { :value => [["admin","admin"], ["player", "player"], ["defender","defender"]] }

#<table><tr><th>Name</th><th>Dna sequence</th><th>Partner</th><th>Person</th></tr>
#<% @oligo_sequences.each do |oligo_sequence| %><tr>
#    <td><%=h oligo_sequence.verbose_me %></td>
#    <td><%=h oligo_sequence.dna_ellipsis %></td>
#    <td><%=h oligo_sequence.partner_name %></td>
#    <td><%=h oligo_sequence.people_name %></td>
#    <td><%= link_to 'Show', oligo_sequence %></td>
#    <% if auth_user(oligo_sequence.partner_id) or signed_in_and_master? %>
#      <td><%= link_to 'Edit', edit_oligo_sequence_path(oligo_sequence) %></td>
#      <td><%= link_to 'Delete', oligo_sequence, :confirm => 'Are you sure?', :method => :delete %></td>
#    <% end %>
#</tr><% end %></table>

  # GET /oligo_sequences/1
  # GET /oligo_sequences/1.xml
  def show
    @oligo_sequence = OligoSequence.find(params[:id])
    if @oligo_sequence.nil?
        redirect_to :action => "index"
    end
    @title = "Oligo sequence"
    @e = Experiment.find(@oligo_sequence.experiment_id)


    
    #@pt = Partner.find(@oligo_sequence.partner_id)
    #<%=h @pt.name %>
    #@taxo = Name.find(@oligo_sequence.tax_id_id)
    #<%=h @taxo.verbose_me %>
 
    respond_to do |format|
       format.html # show.html.erb
       format.xml  { render :xml => @oligo_sequence }
      end   
  end

  # GET /oligo_sequences/new
  # GET /oligo_sequences/new.xml
  def new
    @oligo_sequence = OligoSequence.new
    @title = "Oligo sequence"

    @e_c = Experiment.count()
    if @e_c.nil? or @e_c == 0
      flash[:error] = "No experiment found! create first someone..."
      redirect_to :action => "index"
      return
    end

    @pt = get_partner
    if @pt.nil?
      @e = Experiment.all()
    else
      @e = Experiment.all(:conditions => [ "partner_id = ?", @pt.id])
    end
    @ex = @e.first
    if !@ex.nil?
        @codegen = get_code(@ex.id)
    else
      flash[:error] = "No Experiment created by you found! create your own first experiment before inserting oligo sequence..."
      redirect_to :action => "index"
      return
    end 

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @oligo_sequence }
    end
  end

  # GET /oligo_sequences/1/edit
  def edit
    @oligo_sequence = OligoSequence.find(params[:id])
    @title = "oligo sequence"

    @oligo_exp_code = @oligo_sequence.oligo_exp_code
    @experiment = Experiment.find(@oligo_sequence.experiment_id)

    @pt = Partner.find(@oligo_sequence.partner_id)
    @peo = Person.find(@oligo_sequence.people_id)

    @tree2 = ""
    #<pre id="resbio2"><%= @tree2 %></pre> <br />
    #@tree3 =  Bio::NCBI::REST::ESearch.taxonomy('tardig%')
    #@tree =  Bio::NCBI::REST::EFetch.taxonomy(12475)
    if not @oligo_sequence.taxonomy_id.nil?
    #    @tree2 =  Bio::NCBI::REST::EFetch.taxonomy(265554, 'xml')
    #else
        @tree2 =  Bio::NCBI::REST::EFetch.taxonomy(@oligo_sequence.taxonomy_id, 'xml')
    end    
  end

  # POST /oligo_sequences
  # POST /oligo_sequences.xml
  def create
    @oligo_sequence = OligoSequence.new(params[:oligo_sequence])
    @title = "Oligo_sequence"

    @oligo_sequence.code = get_code(@oligo_sequence.experiment_id)
    @oligo_sequence.dna_sequence = @oligo_sequence.dna_sequence.upcase

    @asso = PartnerPerson.find(:first, 
        :conditions => [ "person_id = ? AND partner_id = ?", @oligo_sequence.people_id, @oligo_sequence.partner_id])
    unless @asso.nil?
      #set the selected item
      @oligo_sequence.partner_people_id = @asso.id
    end

    #deprecated field self.pore_size   
#    @wf = Wfilter.find(@filter_sample.wfilter_id) 
#    if !@wf.nil?
#        @filter_sample.pore_size = @wf.pore_size  
#    else
#        @filter_sample.pore_size = 0  
#    end 

    respond_to do |format|
      if @oligo_sequence.save
        format.html { redirect_to(@oligo_sequence, :notice => 'Oligo sequence was successfully created.') }
        format.xml  { render :xml => @oligo_sequence, :status => :created, :location => @filter_sample }
      else
        @e_c = Experiment.count()

        @pt = get_partner
        if @pt.nil?
          @e = Experiment.all()
        else
          @e = Experiment.all(:conditions => [ "partner_id = ?", @pt.id])
        end
        format.html { render :action => "new" }
        format.xml  { render :xml => @oligo_sequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /oligo_sequences/1
  # PUT /oligo_sequences/1.xml
  def update
    @oligo_sequence = OligoSequence.find(params[:id])
    @title = "oligo sequence"

    if !params[:oligo_sequence][:dna_sequence].nil?
        params[:oligo_sequence][:dna_sequence] = params[:oligo_sequence][:dna_sequence].upcase
    end
    respond_to do |format|
      if @oligo_sequence.update_attributes(params[:oligo_sequence])
        format.html { redirect_to(@oligo_sequence, :notice => 'OligoSequence was successfully updated.') }
        format.xml  { head :ok }
      else

        @pt = Partner.find(@oligo_sequence.partner_id)
        @peo = Person.find(@oligo_sequence.people_id)
        if @oligo_sequence.taxonomy_id.nil?
            @tree =  Bio::NCBI::REST::EFetch.taxonomy(42241)
            @tree2 =  Bio::NCBI::REST::EFetch.taxonomy(42241, 'xml') #265554, 'xml')
        else
            @tree =  Bio::NCBI::REST::EFetch.taxonomy(@oligo_sequence.taxonomy_id)
            @tree2 =  Bio::NCBI::REST::EFetch.taxonomy(@oligo_sequence.taxonomy_id, 'xml')
        end

        format.html { render :action => "edit" }
        format.xml  { render :xml => @oligo_sequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /oligo_sequences/1
  # DELETE /oligo_sequences/1.xml
	  def destroy
    @oligo_sequence = OligoSequence.find(params[:id])
    @oligo_sequence.destroy
    @title = "oligo sequence"

    respond_to do |format|
      format.html { redirect_to(oligo_sequences_url) }
      format.xml  { head :ok }
    end
  end


  private

    def correct_user
      @oligo_sequence = OligoSequence.find(params[:id])
      @experiment = Experiment.find(@oligo_sequence.experiment_id)
      @partner = Partner.find(@experiment.partner_id)
      @user = User.find(@partner.user_id)
      #uses the current_user? method,
      #which (as with deny_access) we will define in the Sessions helper
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the oligo sequence can modify it."
      redirect_to(oligo_sequences_path)
    end

    
    def get_code(pexperiment_id)
      @codegen = "???"
      if pexperiment_id.nil?
        return @codegen
      end
#      psampling_id = psampling.id
#      if psampling_id.nil?
#        return @codegen
#      end

      @pt = Experiment.find(pexperiment_id)
      if not @pt.nil?
          @codegen = @pt.code
      end      
      @codegen += "-"
      @codegen += "Oligo"
    
      #@cnt = FilterSample.calculate(:count, :all, :conditions => ['sampling_id = ' + @pid.to_s ])
      @cnt = OligoSequence.count(:conditions => ['experiment_id = ' + pexperiment_id.to_s ])
      if @cnt.nil? or @cnt == 0
        @cnt = 1
      else
         @cnt += 1 
      end

      #2011 create increment number by registered date
      #@cnt = FilterSample.created_at(Time.now)
      #undefined method `where' for #<Class:0xb6d5ec18>
      #@cnt = FilterSample.where("samplingDate >= :start AND samplingDate < :end",
      #         :start => Date.today,
      #         :end   => 1.day.from_now.to_date)
#      @cnt = FilterSample.count(:conditions => ['samplingDate >= ? AND samplingDate < ? ', Date.today, 2.day.from_now.to_date ]
#      if @cnt.nil? or @cnt == 0
#        @cnt = 1
#      else
#         @cnt += 1 
#      end
      @codegen += "%02d" % @cnt

      return @codegen
    end



end




        
























