module Spree
  ProductsHelper.class_eval do
    def google_merchant_tag(xml, key, value)
      return unless value.present?
      if value.respond_to?(:keys)
        xml.tag!("g:#{key}") { nested_google_merchant_tag(xml, value) }
      else
        xml.tag! "g:#{key}", value
      end
    end

    def nested_google_merchant_tag(xml, group)
      group.each do |sub_key, sub_value|
        google_merchant_tag(xml, sub_key, sub_value)
      end
    end

    def feed_title
      manager.feed_title
    end

    def feed_description
      manager.feed_description
    end

    def production_domain
      manager.production_domain
    end
  end
end
