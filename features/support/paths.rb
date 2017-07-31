# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the employee invitation status page/
      '/'

    when /^the new employee invitation page/
      '/'

    when /^the admin user profile page$/
      '/' #change later

    when /^the admins list page$/
      '/admins'
    
    when /^the clients list page$/
      client_path
    
    when /^the profile page of user "(.*)\s(.*)"$/
      user_id = User.where(first_name: $1).where(last_name: $2).first.id
      '/clients/' + user_id.to_s
    
    when /^the profile page of admin "(.*)\s(.*)"$/
      admin_id = Admin.where(first_name: $1).where(last_name: $2).first.id
      '/admins/' + admin_id.to_s
        
    when /^the admin settings edit page of admin "(.*)\s(.*)"$/
      admin_id = Admin.where(first_name: $1).where(last_name: $2).first.id
      admin_settings_edit_path(:id => admin_id)
    
    when /^the admin settings page of admin "(.*)\s(.*)"$/
      admin_id = Admin.where(first_name: $1).where(last_name: $2).first.id
      admin_setting_path(:id => admin_id)  
    
    when /^the change password page of admin "(.*)\s(.*)"$/
      admin_id = Admin.where(first_name: $1).where(last_name: $2).first.id
      admin_pass_change_path(:id => admin_id)  
      
      
    when /^the invite lawyers page$/
      '/' #change later

    when /^the login page$/
      '/users/sign_in'

    when /^the admin login page$/
      '/admins/sign_in'
      
    when /^profile page$/
       #change later '/clients/' + current_user.id

    when /^the referrer profile creation page$/
      '/users/sign_up' #change later

    when /^the referrers page$/
      referrers_path

    when /^the referrers index page$/
      '/users'

    when '^the new user invitation page$'
      '/users/invitation/new'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
