module AdminHelper
  def if_accessible( controller, action)
    logger.info("in if_accessible")

    # get current user
    user = User.find_by_id(session[:userid])
    if user.nil?
      user = User.find_by_username('notloggedin')
    end
    access = nil

    if user
      user.roles.each do |r|
       # logger.info("Checking access to #{controller} #{action} in role #{r.name}\n");
       if r.rights.find_by_controller_and_action(controller, action, :limit => 1)
          logger.info("Role #{r.name} does have access to #{controller}:#{action}\n");
          access = user
        else
          logger.info("Role #{r.name} does NOT have access to #{controller}:#{action}\n");
        end
      end
    end
    access

  end

  def br_link_to_if_accessible( name, options = {}, html_options = {})
     access = link_to_if_accessible(name, options, html_options)
     if access
       access = access + "<br />"
     end
     access
  end

  def td_link_to_if_accessible( name, options = {}, html_options = {})
     access = link_to_if_accessible(name, options, html_options)
     if access
       access = "<td>" + access + "</td>"
     end
     access
  end

  def link_to_if_accessible( name, options = {}, html_options = {})

    access = nil
    if if_accessible(options[:controller], options[:action])
      access = link_to(name, options, html_options)
    end
    access
  end


end
