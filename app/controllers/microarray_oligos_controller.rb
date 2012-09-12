class MicroarrayOligosController < ApplicationController
  
  # GET /MicroarrayOligos
  # GET /MicroarrayOligos.xml
  def index
    @microarray_oligos = MicroarrayOligo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @microarray_oligos }
    end
  end

  def microarray_oligos
    @title = "MicroarrayOligos"
  end

  # GET /MicroarrayOligos/1
  # GET /MicroarrayOligos/1.xml
  def show
    @microarray_oligo = MicroarrayOligo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @microarray_oligo }
    end
  end

  # GET /MicroarrayOligos/new
  # GET /MicroarrayOligos/new.xml
  def new
    @microarray_oligo = MicroarrayOligo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @microarray_oligo }
    end
  end

  # GET /MicroarrayOligos/1/edit
  def edit
    @microarray_oligo = MicroarrayOligo.find(params[:id])
  end

  # MicroarrayOligo /MicroarrayOligos
  # MicroarrayOligo /MicroarrayOligos.xml
  def create
    @microarray_oligo = MicroarrayOligo.new(params[:MicroarrayOligo])

    respond_to do |format|
      if @microarray_oligo.save
        format.html { redirect_to(@microarray_oligo, :notice => 'MicroarrayOligo was successfully created.') }
        format.xml  { render :xml => @microarray_oligo, :status => :created, :location => @microarray_oligo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @microarray_oligo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /MicroarrayOligos/1
  # PUT /MicroarrayOligos/1.xml
  def update
    @microarray_oligo = MicroarrayOligo.find(params[:id])

    respond_to do |format|
      if @microarray_oligo.update_attributes(params[:MicroarrayOligo])
        format.html { redirect_to(@microarray_oligo, :notice => 'MicroarrayOligo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @microarray_oligo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /MicroarrayOligos/1
  # DELETE /MicroarrayOligos/1.xml
  def destroy
    @microarray_oligo = MicroarrayOligo.find(params[:id])
    @microarray_oligo.destroy

    respond_to do |format|
      format.html { redirect_to(microarray_oligos_url) }
      format.xml  { head :ok }
    end
  end

end
