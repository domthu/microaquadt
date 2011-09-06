class PagesController < ApplicationController

  def home
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

  def code_types
    @title = "code types"
  end

  def geos
    @title = "Geographical position"
  end

  def land_use_mappings
    @title = "land use mappings"
  end

  def water_uses
    @title = "water uses"
  end

  def water_types
    @title = "water types"
  end

  def sampling_sites
    @title = "sampling sites"
  end

  def water_samples
    @title = "water samples"
  end

  def partners
    @title = "partners"
  end

  def people
    @title = "people"
  end

  def partner_people
    @title = "association partner <--> people"
  end

  def users
    @title = "users"
  end

  def microposts
    @title = "microposts"
  end

  def posts
    @title = "posts"
  end

  def protocols
    @title = "protocols"
  end

end

