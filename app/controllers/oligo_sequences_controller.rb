class OligoSequencesController < ApplicationController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update]

  # GET /oligo_sequences
  # GET /oligo_sequences.xml
  def index
    @oligo_sequences = OligoSequence.all
    @title = "List of oligo sequences"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @oligo_sequences }
    end
  end

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

    @partners = Partner.find(:all)
    @pt = Partner.find(:first, :conditions => [ "user_id = ?", current_user.id])
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
  end

  # POST /oligo_sequences
  # POST /oligo_sequences.xml
  def create
    @oligo_sequence = OligoSequence.new(params[:oligo_sequence])
    @title = "oligo sequence"

    respond_to do |format|
      if @oligo_sequence.save
        format.html { redirect_to(@oligo_sequence, :notice => 'OligoSequence was successfully created.') }
        format.xml  { render :xml => @oligo_sequence, :status => :created, :location => @oligo_sequence }
      else
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

    respond_to do |format|
      if @oligo_sequence.update_attributes(params[:oligo_sequence])
        format.html { redirect_to(@oligo_sequence, :notice => 'OligoSequence was successfully updated.') }
        format.xml  { head :ok }
      else
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

