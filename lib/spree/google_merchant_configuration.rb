class Spree::GoogleMerchantConfiguration < Spree::Preferences::Configuration
  preference :google_merchant_title,       :string, default: 'My Spree Store'
  preference :google_merchant_description, :string, default: 'RSS feed of our products'
  preference :production_domain,           :string, default: 'http://spreecommerce.com/'
end
