# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "Microaqua"
    if @title.nil?
      base_title
    else
      # user could enter a name with malicious code—called a cross-site scripting attack
      #The solution is to escape potentially problematic code using the h method (short for html_escape)
      "#{base_title} | #{h(@title)}"
    end
  end

  #LOGO
  def appHelperLogo
    #image_tag("logo.png", :alt => "Sample App", :class => "round")
    image_tag("uaqua1_logo2.png", :alt => "Microaqua bioinfo", :class => "round")
  end
end

