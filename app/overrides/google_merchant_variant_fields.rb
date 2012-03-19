Deface::Override.new(:virtual_path => "spree/admin/variants/_form",
                     :name => "google_merchant_variant_fields",
                     :insert_after => "div.right",
                     :partial => "spree/admin/variants/google_merchant_fields")
