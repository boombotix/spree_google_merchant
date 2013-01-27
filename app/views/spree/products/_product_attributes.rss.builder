xml.id variant.id.to_s
xml.title "#{variant.product.name} #{variant_options variant}"
xml.description CGI.escapeHTML(strip_tags(variant.product.description))
xml.link @production_domain + 'products/' + variant.product.permalink
xml.tag! "g:mpn", variant.sku.to_s
xml.tag! "g:id", variant.id.to_s
xml.tag! "g:price", number_to_currency(variant.price)
xml.tag! "g:condition", "new"
xml.tag! "g:image_link", @production_domain.sub(/\/$/, '') + variant.product.images.first.attachment.url(:product) unless variant.product.images.empty?
xml.tag! "g:availability", variant.count_on_hand > 0 ? 'in stock' : 'out of stock'
xml.tag! "g:gtin", variant.google_merchant_gtin
xml.tag! "g:brand", variant.product.google_merchant_brand
xml.tag! "g:google_product_category", variant.product.google_merchant_product_category
xml.tag! "g:product_type", variant.product.google_merchant_product_type
