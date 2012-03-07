require 'spree/core'

module Spree::GoogleMerchant
end
module SpreeGoogleMerchant
  class Engine < Rails::Engine
    engine_name 'spree_google_merchant'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "spree.google_merchant.preferences", :before => :load_config_initializers do |app|
      Spree::GoogleMerchant::Config = Spree::GoogleMerchantConfiguration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../../app/overrides/*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
