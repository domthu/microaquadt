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
    image_tag("uaqua1_logo2.png", :alt => "Microaqua bioinfo", :class => "round", :size => "100x69")
  end

  #BETA
  def appBetaLogo
    image_tag("icon_beta3.jpg", :title => "Database only for Test Purpose", :alt => "Database only for Test Purpose", :class => "round", :size => "69x69")
  end

  #LOGIN
  def appHelperLogin
    #image_tag("login-set.png", :alt => "Microaqua sign in", :class => "usericon navigation")
    content_tag(:div, content_tag(:div, "Microaqua sign in", :class => "form-item"), :class => "usericon")
  end

  def appHelperLoginExtended
    #Kappao non funziona dentro un tag link_to
    #<%= link_to appHelperLoginExtended, signin_path, :controller => 'sessions', :action => 'new' %>
    #    <%= link_to appHelperLoginExtended, signin_path, :controller => 'sessions', :action => 'new' %>
	  return '
	  <div>
	    <div class="usericon">
	      <div class="form-item form-item-name">
          <input type="text" class="form-text required" maxlength="60" size="15"
          value="Username" name="name" id="edit-name"
          onfocus="lun();"
          onblur="lup();">
        </div>
      </div>
      <div class="passicon">
        <div class="form-item form-type-password form-item-pass">
          <input type="password" class="form-text required" maxlength="60" size="15"
          value="Password" name="pass" id="edit-pass"
          onfocus="pun();"
          onblur="pup();">
        </div>
      </div>
    </div>'
  end

  #LOGOUT
  # substitute <li><%= link_to "Sign out " + current_user.name, signout_path, :method => :delete %> </li>
  def appHelperLogout
    #image_tag("login-set.png", :alt => "Microaqua sign out", :class => "passicon navigation")
    #tag("div", :class => "passicon navigation", :data => current_user.name)
    content_tag(:div, content_tag(:div, current_user.name, :class => "form-item"), :class => "passicon")
    #content_tag(:div, current_user.name, :class => "passicon")
    #tag("div", :class => "passicon")
    #tag("div", :data => {:name => 'Stephen', :city_state => %w(Chicago IL)},)
    # => <div data-name="Stephen" data-city-state="[&quot;Chicago&quot;,&quot;IL&quot;]" />
  end

  #GRAVATAR substitute for Plugin (incompatible version?)
  def avatar_url(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
    end
  end
  #use as <%= image_tag avatar_url(user) %>

end

