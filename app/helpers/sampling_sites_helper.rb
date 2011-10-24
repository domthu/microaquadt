module SamplingSitesHelper

  # In the helper...
  def link_to_thing(text, thing)
    link_to(text, edit_sampling_site_path(thing))
  end
  # In the view...
  #<%= link_to_think("text", @thing) %>

end
