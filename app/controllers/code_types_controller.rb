class CodeTypesController < ApplicationController
  # GET /code_types
  # GET /code_types.xml
  def index
    @code_types = CodeType.all
    @title = "code types"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @code_types }
    end
  end

  # GET /code_types/1
  # GET /code_types/1.xml
  def show
    @code_type = CodeType.find(params[:id])
    @title = "code types"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @code_type }
    end
  end

  # GET /code_types/new
  # GET /code_types/new.xml
  def new
    @code_type = CodeType.new
    @title = "code type"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @code_type }
    end
  end

  # GET /code_types/1/edit
  def edit
    @code_type = CodeType.find(params[:id])
    @title = "code type"
  end

  # POST /code_types
  # POST /code_types.xml
  def create
    @code_type = CodeType.new(params[:code_type])
    @title = "code type"

    respond_to do |format|
      if @code_type.save
        format.html { redirect_to(@code_type, :notice => 'CodeType was successfully created.') }
        format.xml  { render :xml => @code_type, :status => :created, :location => @code_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @code_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /code_types/1
  # PUT /code_types/1.xml
  def update
    @code_type = CodeType.find(params[:id])
    @title = "code type"

    respond_to do |format|
      if @code_type.update_attributes(params[:code_type])
        format.html { redirect_to(@code_type, :notice => 'CodeType was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @code_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /code_types/1
  # DELETE /code_types/1.xml
  def destroy
    @code_type = CodeType.find(params[:id])
    @code_type.destroy
    @title = "code type"

    respond_to do |format|
      format.html { redirect_to(code_types_url) }
      format.xml  { head :ok }
    end
  end
end
