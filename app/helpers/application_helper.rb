# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "Microaqua"
    if @title.nil?
      base_title
    else
      #"#{base_title} | #{@title}" using the h method (short for html_escape)
      "#{base_title} | #{h(@title)}"
    end
  end
end

