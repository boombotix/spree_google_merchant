Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                     :name => "google_merchant_product_fields",
                     :insert_bottom => "[data-hook='admin_product_form_additional_fields']",
                     :partial => "admin/products/google_merchant_fields")
