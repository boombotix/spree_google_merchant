module SpreeGoogleMerchant
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_initializer
        create_file "config/initializers/google_merchant.rb", <<-FILE
# Override the manager:
# module Spree
#   module GoogleMerchant
#     class CustomProductManager < ProductManager
#       # Override methods:
#       def variant_path(variant)
#         'products/' + variant.product.slug
#       end
#
#       .
#       .
#       .
#
#     end
#
#     send(:remove_const, :Manager)
#     Manager = CustomProductManager.new
#   end
# end


Spree::GoogleMerchant::Manager.tap do |config|
  # config.include_variants = false

  # Replace/add to/remove from product_mapping.
  # default is {
  #   google_merchant_product_category: "google_product_category",
  #   google_merchant_brand: "brand",
  #   google_merchant_department: "department",
  #   google_merchant_color: "color",
  #   google_merchant_gtin: "gtin"
  # }

  # config.product_mapping.delete(:google_merchant_product_category)

  # config.product_mapping.merge!(
  #   material: "material"
  # )

  # Set a variant_mapping.
  # config.variant_mapping = {
  #   'my-color' => 'color',
  #   .
  #   .
  #   .
  # }

  # Set fallback values for values that don't change across products.
  # config.product_fallbacks = {
  #   brand: 'My Brand',
  #   .
  #   .
  #   .
  # }

  # Customize what's considered "the first image".
  # config.advertising_image_proc = ->{ where(<something>).order(:position) }

  # Set the units used for weight. Valid values are: lb, oz, g, or kg
  # config.weight_unit = 'lb'
end
        FILE
      end

    end
  end
end
