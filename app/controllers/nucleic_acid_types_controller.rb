class NucleicAcidTypesController < ApplicationController
  # GET /nucleic_acid_types
  # GET /nucleic_acid_types.xml
  def index
    @nucleic_acid_types = NucleicAcidType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nucleic_acid_types }
    end
  end

  # GET /nucleic_acid_types/1
  # GET /nucleic_acid_types/1.xml
  def show
    @nucleic_acid_type = NucleicAcidType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nucleic_acid_type }
    end
  end

  # GET /nucleic_acid_types/new
  # GET /nucleic_acid_types/new.xml
  def new
    @nucleic_acid_type = NucleicAcidType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nucleic_acid_type }
    end
  end

  # GET /nucleic_acid_types/1/edit
  def edit
    @nucleic_acid_type = NucleicAcidType.find(params[:id])
  end

  # POST /nucleic_acid_types
  # POST /nucleic_acid_types.xml
  def create
    @nucleic_acid_type = NucleicAcidType.new(params[:nucleic_acid_type])

    respond_to do |format|
      if @nucleic_acid_type.save
        format.html { redirect_to(@nucleic_acid_type, :notice => 'NucleicAcidType was successfully created.') }
        format.xml  { render :xml => @nucleic_acid_type, :status => :created, :location => @nucleic_acid_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nucleic_acid_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nucleic_acid_types/1
  # PUT /nucleic_acid_types/1.xml
  def update
    @nucleic_acid_type = NucleicAcidType.find(params[:id])

    respond_to do |format|
      if @nucleic_acid_type.update_attributes(params[:nucleic_acid_type])
        format.html { redirect_to(@nucleic_acid_type, :notice => 'NucleicAcidType was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nucleic_acid_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nucleic_acid_types/1
  # DELETE /nucleic_acid_types/1.xml
  def destroy
    @nucleic_acid_type = NucleicAcidType.find(params[:id])
    @nucleic_acid_type.destroy

    respond_to do |format|
      format.html { redirect_to(nucleic_acid_types_url) }
      format.xml  { head :ok }
    end
  end
end
