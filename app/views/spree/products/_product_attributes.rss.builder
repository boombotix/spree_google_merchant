google_merchant_product_category = Spree::Property.where(name: "google_merchant_product_category").first
category = variant.product.product_properties.where(property_id: google_merchant_product_category.id).first

xml.title "#{variant.product.name} #{variant_options variant}"
xml.description variant.product.description
xml.link @production_domain + 'products/' + variant.product.permalink
xml.tag! "sku", variant.sku.to_s
xml.tag! "price", variant.price
xml.tag! "category", HTMLEntities.new.decode category.value if category
xml.tag! "brand", variant.product.properties.where(name: "google_merchant_brand").first
xml.tag! "department", variant.product.properties.where(name: "google_merchant_gender").first
xml.tag! "image", variant.product.images.first.attachment.url(:product) unless variant.product.images.empty?
xml.tag! "color", variant.product.properties.where(name: "google_merchant_color").first
xml.tag! "GTIN", variant.product.properties.where(name: "google_merchant_gtin").first
xml.tag! "g:condition", "new"
xml.tag! "g:availability", variant.count_on_hand > 0 ? 'in stock' : 'out of stock'
xml.tag! "shipping_weight", variant.weight.to_s
