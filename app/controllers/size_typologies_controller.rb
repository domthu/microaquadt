class SizeTypologiesController < ApplicationController
  # GET /size_typologies
  # GET /size_typologies.xml
  def index
    @size_typologies = SizeTypology.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @size_typologies }
    end
  end

  # GET /size_typologies/1
  # GET /size_typologies/1.xml
  def show
    @size_typology = SizeTypology.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @size_typology }
    end
  end

  # GET /size_typologies/new
  # GET /size_typologies/new.xml
  def new
    @size_typology = SizeTypology.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @size_typology }
    end
  end

  # GET /size_typologies/1/edit
  def edit
    @size_typology = SizeTypology.find(params[:id])
  end

  # POST /size_typologies
  # POST /size_typologies.xml
  def create
    @size_typology = SizeTypology.new(params[:size_typology])

    respond_to do |format|
      if @size_typology.save
        format.html { redirect_to(@size_typology, :notice => 'SizeTypology was successfully created.') }
        format.xml  { render :xml => @size_typology, :status => :created, :location => @size_typology }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @size_typology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /size_typologies/1
  # PUT /size_typologies/1.xml
  def update
    @size_typology = SizeTypology.find(params[:id])

    respond_to do |format|
      if @size_typology.update_attributes(params[:size_typology])
        format.html { redirect_to(@size_typology, :notice => 'SizeTypology was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @size_typology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /size_typologies/1
  # DELETE /size_typologies/1.xml
  def destroy
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to size_typologies_path
    else

        @size_typology = SizeTypology.find(params[:id])
        @size_typology.destroy

        respond_to do |format|
          format.html { redirect_to(size_typologies_url) }
          format.xml  { head :ok }
        end
    end
  end
end
