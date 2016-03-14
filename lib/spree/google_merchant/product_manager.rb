module Spree
  module GoogleMerchant
    class ProductManager
      include Spree::BaseHelper

      DEFAULT_MAPPING = {
        google_merchant_product_category: "google_product_category",
        google_merchant_brand: "brand",
        google_merchant_department: "department",
        google_merchant_color: "color",
        google_merchant_gtin: "gtin"
      }

      VALID_WEIGHT_UNITS = %w(lb oz g kg)

      attr_accessor :product_fallbacks, :advertising_image_proc, :weight_unit
      attr_writer :include_variants
      attr_reader :product_mapping, :variant_mapping

      def initialize
        @product_mapping = HashWithIndifferentAccess.new(DEFAULT_MAPPING)
        @product_fallbacks = {}
        @variant_mapping = {}
        @include_variants = false
        @advertising_image_proc = ->{order(:position)}
        @weight_unit = VALID_WEIGHT_UNITS.first
      end

      def product_mapping=(hash)
        @product_mapping = HashWithIndifferentAccess.new(hash)
      end

      def variant_mapping=(hash)
        @variant_mapping = HashWithIndifferentAccess.new(hash)
      end

      def product_keys
        product_mapping.keys
      end

      def variant_keys
        variant_mapping.keys
      end

      def include_variants?
        @include_variants.present?
      end

      def property_ids
        Spree::Property.where(name: product_keys)
      end

      def property_set(products)
        lookup_properties
        products.inject(HashWithIndifferentAccess.new) do |set, product|
          set.merge(product => properties_for(product))
        end
      end

      def option_values_for(variant)
        all_values = options_for(variant).inject({}) do |x,k|
          x.merge(k.option_type.name => k)
        end
        variant_keys.inject(HashWithIndifferentAccess.new) do |values, key|
          value = all_values[key].try(:presentation)
          value ? values.merge(variant_mapping[key] => value) : values
        end
      end

      def variant_path(variant)
        'products/' + variant.product.slug
      end

      def title(variant)
        "#{variant.product.name} #{variant_options variant}"
      end

      def feed_title
        Spree::GoogleMerchant::Config[:google_merchant_title]
      end

      def feed_description
        Spree::GoogleMerchant::Config[:google_merchant_description]
      end

      def production_domain
        Spree::GoogleMerchant::Config[:production_domain]
      end

      private

      attr_reader :properties

      def lookup_properties
        @properties = Spree::ProductProperty.google_properties.inject(
          Hash.new { [] }
        ) do |set, pp|
          id = pp.product_id
          set.merge(id => set[id] << pp)
        end
      end

      def properties_for(product)
        properties[product.id].inject(
          HashWithIndifferentAccess.new(product_fallbacks)
        ) do |set, pp|
          set.merge(product_mapping[pp.name] => pp.value)
        end
      end

      def options_for(variant)
        variant.option_values.select { |ov| ov.option_type.name.in?(variant_keys) }
      end
    end
  end
end
