Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
                     :name => "google_merchange_admin_configurations_menu",
                     :insert_after => "[data-hook='admin_configurations_menu'], #admin_configurations_menu[data-hook]",
                     :text => "<%= configurations_menu_item(t(\"google_merchant\"), admin_google_merchants_path, t(\"google_merchants_description\")) %>",
                     :disabled => false)