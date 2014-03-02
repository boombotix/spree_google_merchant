Deface::Override.new(
  virtual_path:  "spree/admin/shared/_configuration_menu",
  name:          "google_merchange_admin_configurations_menu",
  insert_bottom: "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
  text:          "<li<%== ' class=\"active\"' if controller.controller_name == 'theme_settings' %>><%= link_to \"Google Merchant\", admin_google_merchants_path %></li>",
  disabled:      false
)
