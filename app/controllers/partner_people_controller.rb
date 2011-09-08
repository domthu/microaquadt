class PartnerPeopleController < ApplicationController
  # GET /partner_people
  # GET /partner_people.xml
  def index
    @partner_people = PartnerPerson.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @partner_people }
    end
  end

  def partner_people
    @title = "association partner <--> people"
  end

  # GET /partner_people/1
  # GET /partner_people/1.xml
  def show
    @partner_person = PartnerPerson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @partner_person }
    end
  end

  # GET /partner_people/new
  # GET /partner_people/new.xml
  def new
    @partner_person = PartnerPerson.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @partner_person }
    end
  end

  # GET /partner_people/1/edit
  def edit
    @partner_person = PartnerPerson.find(params[:id])
  end

  # POST /partner_people
  # POST /partner_people.xml
  def create
    @partner_person = PartnerPerson.new(params[:partner_person])

    respond_to do |format|
      if @partner_person.save
        format.html { redirect_to(@partner_person, :notice => 'PartnerPerson was successfully created.') }
        format.xml  { render :xml => @partner_person, :status => :created, :location => @partner_person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @partner_person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /partner_people/1
  # PUT /partner_people/1.xml
  def update
    @partner_person = PartnerPerson.find(params[:id])

    respond_to do |format|
      if @partner_person.update_attributes(params[:partner_person])
        format.html { redirect_to(@partner_person, :notice => 'PartnerPerson was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @partner_person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /partner_people/1
  # DELETE /partner_people/1.xml
  def destroy
    @partner_person = PartnerPerson.find(params[:id])
    @partner_person.destroy

    respond_to do |format|
      format.html { redirect_to(partner_people_url) }
      format.xml  { head :ok }
    end
  end
end
