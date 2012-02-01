class NucleicAcidsController < ApplicationController
  # GET /nucleic_acids
  # GET /nucleic_acids.xml
  def index
    @nucleic_acids = NucleicAcid.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nucleic_acids }
    end
  end

  # GET /nucleic_acids/1
  # GET /nucleic_acids/1.xml
  def show
    @nucleic_acid = NucleicAcid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nucleic_acid }
    end
  end

  # GET /nucleic_acids/new
  # GET /nucleic_acids/new.xml
  def new
    @nucleic_acid = NucleicAcid.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nucleic_acid }
    end
  end

  # GET /nucleic_acids/1/edit
  def edit
    @nucleic_acid = NucleicAcid.find(params[:id])
  end

  # POST /nucleic_acids
  # POST /nucleic_acids.xml
  def create
    @nucleic_acid = NucleicAcid.new(params[:nucleic_acid])

    respond_to do |format|
      if @nucleic_acid.save
        format.html { redirect_to(@nucleic_acid, :notice => 'NucleicAcid was successfully created.') }
        format.xml  { render :xml => @nucleic_acid, :status => :created, :location => @nucleic_acid }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nucleic_acid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nucleic_acids/1
  # PUT /nucleic_acids/1.xml
  def update
    @nucleic_acid = NucleicAcid.find(params[:id])

    respond_to do |format|
      if @nucleic_acid.update_attributes(params[:nucleic_acid])
        format.html { redirect_to(@nucleic_acid, :notice => 'NucleicAcid was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nucleic_acid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nucleic_acids/1
  # DELETE /nucleic_acids/1.xml
  def destroy
    @nucleic_acid = NucleicAcid.find(params[:id])
    @nucleic_acid.destroy

    respond_to do |format|
      format.html { redirect_to(nucleic_acids_url) }
      format.xml  { head :ok }
    end
  end
end
