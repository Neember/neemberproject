# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items.
  # Defaults to 'selected' navigation.selected_class = 'your_selected_class'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  # navigation.active_leaf_class = 'your_active_leaf_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that
  # will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name, item| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false
  
  # If this option is set to true, all item names will be considered as safe (passed through html_safe). Defaults to false.
  # navigation.consider_item_names_as_safe = false

  # Define the primary navigation
  navigation.items do |primary|
    primary.dom_class = 'nav navbar-nav'
    primary.item :clients, 'Clients', clients_path do |submenu|
      submenu.item :new, 'Add New Client', new_client_path
    end
    primary.item :projects, 'Projects', projects_path do |submenu|
      submenu.item :new, 'Add New Project', new_project_path
    end

    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    # primary.item :key_3, 'Admin', url, class: 'special', if: -> { current_user.admin? }
    # primary.item :key_4, 'Account', url, unless: -> { logged_in? }

    # you can also specify html attributes to attach to this particular level
    # works for all levels of the menu
    # primary.dom_attributes = {id: 'menu-id', class: 'menu-class'}

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false
  end
end