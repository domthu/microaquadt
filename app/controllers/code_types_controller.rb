class CodeTypesController < AuthController   # < AuthController

  #only Requiring the right user to change own contents
  before_filter :correct_user, :only => [:edit, :update]

  # GET /code_types
  # GET /code_types.xml
  def index
    @code_types = CodeType.all
    @title = "code types"
    #<td><%=h code_type.partner.verbose %></td>

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @code_types }
    end
  end

  # GET /code_types/1
  # GET /code_types/1.xml
  def show
    @code_type = CodeType.find(params[:id])
    @title = "code type"
    @pt = Partner.find(@code_type.partner_id)

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

    @partners = Partner.find(:all)
    @pt = get_partner
    unless @pt.nil?
      #set the selected item
      @code_type.partner_id = @pt.id
    end

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
    @partners = Partner.find(:all)

    respond_to do |format|
      if @code_type.save
        format.html { redirect_to(@code_type, :notice => 'CodeType was successfully created.') }
        format.xml  { render :xml => @code_type, :status => :created, :location => @code_type }
      else

        @partners = Partner.find(:all)
        @pt = get_partner
        unless @pt.nil?
          #set the selected item
          @code_type.partner_id = @pt.id
        end

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
    if !signed_in_and_master?
      flash[:notice] = "Sorry. Only technical manager can delete data. Please, contact Roberto SPURIO to do it."
      redirect_to water_types_path
    else

        @code_type = CodeType.find(params[:id])
        @code_type.destroy
        @title = "code type"

        respond_to do |format|
          format.html { redirect_to(code_types_url) }
          format.xml  { head :ok }
        end
    end
  end


  private

    def correct_user
      @codetype = CodeType.find(params[:id])
      @partner = Partner.find(@codetype.partner_id)
      @user = User.find(@partner.user_id)
      #uses the current_user? method,
      #which (as with deny_access) we will define in the Sessions helper
      reroute() unless current_user?(@user)
    end

    def reroute()
      flash[:notice] = "Only the partner who create the code type can modify it."
      redirect_to(code_types_path)
    end
end

