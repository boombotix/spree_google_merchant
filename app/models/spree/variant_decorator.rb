module Spree
  Variant.class_eval do
    validates :google_merchant_gtin, :length => { :maximum => 255 }
  end
end