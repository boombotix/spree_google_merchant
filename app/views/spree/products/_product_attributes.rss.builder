# docs: https://support.google.com/merchants/answer/188494?hl=en

xml.tag! "g:id", variant.sku.to_s
xml.tag! "g:title", manager.title(variant)
xml.tag! "g:description", variant.product.description
xml.tag! "g:link", production_domain + manager.variant_path(variant)
xml.tag! "g:image_link", variant.advertising_image_url.gsub(/^\//, 'http:/') if variant.advertising_image
xml.tag! "g:condition", "new"
xml.tag! "g:availability", in_stock.include?(variant.id) ? 'in stock' : 'out of stock'
xml.tag! "g:price", "#{variant.default_price.display_amount.money} #{variant.default_price.currency}"
xml.tag! "g:mpn", variant.sku.to_s
xml.tag! "g:shipping_weight", "#{variant.weight} #{manager.weight_unit}"
xml.tag! "g:item_group_id", variant.master.sku.to_s if include_variants?
properties[variant.product].merge(manager.option_values_for(variant)).each do |key, value|
  google_merchant_tag(xml, key, value)
end
