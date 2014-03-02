module Spree
  ProductsController.class_eval do
    def google_merchant
      @products = Product.active
      # respond_to :rss
      # respond_with @products
    end
  end
end
