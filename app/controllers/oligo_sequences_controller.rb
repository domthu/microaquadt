class OligoSequencesController < AuthController   #ApplicationController

require 'faster_csv'
require 'fastercsv'

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

    #oligo_sequences = OligoSequence.find(:all, :joins => [:people, :partner]) do
#KAPPAO: Association named 'people' was not found; perhaps you misspelled it?
    #oligo_sequences = OligoSequence.find(:all, :joins => [:person, :partner]) do
#Mysql::Error: Unknown column 'oligo_sequences.person_id' in 'on clause': SELECT `oligo_sequences`.* FROM `oligo_sequences`   INNER JOIN `people` ON `people`.id = `oligo_sequences`.person_id  INNER JOIN `partners` ON `partners`.id = `oligo_sequences`.partner_id   LIMIT 0, 20
#KAPPAO: migrate person generate people table but the rails do not re-construct right renaming
    _str = ""
    oligo_sequences = OligoSequence.find(:all, :joins => [:partner]) do
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
        if params[:sidx] == "verbose_me"
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
        else
            order_by "#{params[:sidx]} #{params[:sord]}"
        end
    end

    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @oligo_sequences } 
      format.json { render :json => oligo_sequences.to_jqgrid_json(
            [:id, "act", :code,"verbose_me", "dna_ellipsis", "partner_name", "people_name", :taxonomy_name, :taxonomy_id, :available, "edit"],
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
    @title = "Oligo sequence"
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

    #<%= collection_select(:oligo_sequence, :partner_id, @partners, :id, :verbose_me, options ={}, :class =>"partner") %>

    @pt = get_partner
    unless @pt.nil?
      #set the selected item
      @oligo_sequence.partner_id = @pt.id
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
    @title = "oligo sequence"

    @oligo_sequence.dna_sequence = @oligo_sequence.dna_sequence.upcase

    @asso = PartnerPerson.find(:first, 
        :conditions => [ "person_id = ? AND partner_id = ?", @oligo_sequence.people_id, @oligo_sequence.partner_id])
    unless @asso.nil?
      #set the selected item
      @oligo_sequence.partner_people_id = @asso.id
    end

    respond_to do |format|
      if @oligo_sequence.save
        format.html {  flash[:notice] = 'OligoSequence is successfully created. Click on the "+" sign on individual row, to check, which microarray experiments have utilized your oligo!!! ' 
                    redirect_to :action => "index"}
        format.xml  { render :xml => @oligo_sequence, :status => :created, :location => @oligo_sequence }
      else

        @pt = get_partner
        unless @pt.nil?
          #set the selected item
          @oligo_sequence.partner_id = @pt.id
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

  def export_to_csv
      
    data = params['data'].split(',')
    @oligos = OligoSequence.find(:all, :conditions => [ "id IN (?)", data])
    
    file = FasterCSV.generate do |line|
    cols = ["ID","Details","PartnerCode","DNASequence","Date","Partner","Person","TaxName","TaxID"]
    line << cols

    @oligos.each do |entry|                
    line << [entry.id, entry.description, entry.code, entry.dna_ellipsis, entry.oligoDate, entry.name, entry.people_name, entry.taxonomy_name, entry.taxonomy_id ]
        end  

    end
     
    #respond_to do |format|
	#   format.xls { render :xls => @oligos }
	#end
    send_data(file)


  end

  def export_all

    @oligos = OligoSequence.all

    csv = FasterCSV.generate do |line|
    cols = ["ID","Details","PartnerCode","DNASequence","Date","Partner","Person","TaxName","TaxID"]
    line << cols

    @oligos.each do |entry|                
    line << [entry.id, entry.description, entry.code, entry.dna_ellipsis, entry.oligoDate, entry.name, entry.people_name, entry.taxonomy_name, entry.taxonomy_id ]
        end  

    end
    
    send_data(csv, 
    :type => 'text/csv; charset=iso-8859-1; header=present', 
    :disposition => "attachment; filename=Oligo_data_#{Time.now.strftime('%d%m%y-%H%M')}.csv")
     

  end

  def export_all_xls

    @oligos = OligoSequence.all

    respond_to do |format|
	   format.xls { render :xls => @oligos }
	end
     

  end


  private

    def correct_user
      @oligo = OligoSequence.find(params[:id])
      @partner = Partner.find(@oligo.partner_id)
      @user = User.find(@partner.user_id)
      #uses the current_user? method,
      #which (as with deny_access) we will define in the Sessions helper
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the oligo sequence can modify it."
      redirect_to(oligo_sequences_path)
    end

    


end




        
























