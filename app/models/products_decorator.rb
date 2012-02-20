Product.class_eval do
  delegate_belongs_to :master, :google_merchant_gtin, :google_merchant_brand, :google_merchant_product_category, :google_merchant_product_type
end
