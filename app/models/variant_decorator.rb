Variant.class_eval do
  validates :google_merchant_gtin, :length => { :maximum => 255 }
  validates :google_merchant_brand, :length => { :maximum => 255 }
  validates :google_merchant_product_category, :length => { :maximum => 255 }
  validates :google_merchant_product_type, :length => { :maximum => 255 }
end
