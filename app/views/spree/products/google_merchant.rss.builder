xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"

xml.rss "version" => "2.0", "xmlns:g" => "http://base.google.com/ns/1.0" do
  xml.channel do
    xml.title Spree::GoogleMerchant::Config[:google_merchant_title]
    xml.description Spree::GoogleMerchant::Config[:google_merchant_description]

    production_domain = Spree::GoogleMerchant::Config[:production_domain]
    xml.link production_domain

    @products.each do |product|
      if product.google_merchant_include_variants
        product.variants.each do |variant|
          xml.item do
            xml.id product.id.to_s
            xml.title "#{product.name} #{variant_options variant}"
            xml.description CGI.escapeHTML(strip_tags(product.description))
            xml.link production_domain + 'products/' + product.permalink
            xml.tag! "g:mpn", variant.sku.to_s
            xml.tag! "g:id", variant.id.to_s
            xml.tag! "g:price", number_to_currency(variant.price)
            xml.tag! "g:condition", "new"
            xml.tag! "g:image_link", production_domain.sub(/\/$/, '') + product.images.first.attachment.url(:product) unless product.images.empty?
            xml.tag! "g:availability", variant.on_hand > 0 ? 'in stock' : 'out of stock'
            xml.tag! "g:gtin", variant.google_merchant_gtin
            xml.tag! "g:brand", product.google_merchant_brand
            xml.tag! "g:google_product_category", product.google_merchant_product_category
            xml.tag! "g:product_type", product.google_merchant_product_type
          end
        end
      else
        xml.item do
          xml.id product.id.to_s
          xml.title product.name
          xml.description CGI.escapeHTML(strip_tags(product.description))
          xml.link production_domain + 'products/' + product.permalink
          xml.tag! "g:mpn", product.sku.to_s
          xml.tag! "g:id", product.master.id.to_s
          xml.tag! "g:price", number_to_currency(product.price)
          xml.tag! "g:condition", "new"
          xml.tag! "g:image_link", production_domain.sub(/\/$/, '') + product.images.first.attachment.url(:product) unless product.images.empty?
          xml.tag! "g:availability", product.on_hand > 0 ? 'in stock' : 'out of stock'
          xml.tag! "g:gtin", product.google_merchant_gtin
          xml.tag! "g:brand", product.google_merchant_brand
          xml.tag! "g:google_product_category", product.google_merchant_product_category
          xml.tag! "g:product_type", product.google_merchant_product_type
        end
      end
    end
  end
end