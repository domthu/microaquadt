class BatchImagesController < ApplicationController
  # GET /batch_images
  # GET /batch_images.xml
  def index
    @batch_images = BatchImage.all
    @title = "Batch upload of microarray images"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @batch_images }
    end
  end

  # GET /batch_images/1
  # GET /batch_images/1.xml
  def show
    @batch_image = BatchImage.find(params[:id])
    @title = "Batch upload of microarray images"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @batch_image }
    end
  end

  # GET /batch_images/new
  # GET /batch_images/new.xml
  def new
    @batch_image = BatchImage.new
    @title = "Batch upload of microarray images"


    10.times {@batch_image.image_assets.build}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @batch_image }
    end
  end

  # GET /batch_images/1/edit
  def edit
    @batch_image = BatchImage.find(params[:id])
  end

  # POST /batch_images
  # POST /batch_images.xml
  def create
    @batch_image = BatchImage.new(params[:batch_image])
    @title = "Batch upload of microarray images"

    respond_to do |format|
      if @batch_image.save
        format.html { redirect_to(@batch_image, :notice => 'BatchImage was successfully created.') }
        format.xml  { render :xml => @batch_image, :status => :created, :location => @batch_image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @batch_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /batch_images/1
  # PUT /batch_images/1.xml
  def update
    @batch_image = BatchImage.find(params[:id])

    respond_to do |format|
      if @batch_image.update_attributes(params[:batch_image])
        format.html { redirect_to(@batch_image, :notice => 'BatchImage was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @batch_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /batch_images/1
  # DELETE /batch_images/1.xml
  def destroy
    @batch_image = BatchImage.find(params[:id])
    @batch_image.destroy

    respond_to do |format|
      format.html { redirect_to(batch_images_url) }
      format.xml  { head :ok }
    end
  end
end
