module Spree
  Variant.class_eval do
    attr_accessible :google_merchant_gtin
    validates :google_merchant_gtin, :length => { :maximum => 255 }
  end
end