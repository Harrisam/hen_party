# Taken from the cucumber-rails project.

module NavigationHelpers

  # Maps a name to a path.
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      root_path

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    when /the sign up page/
      new_user_registration_path

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)