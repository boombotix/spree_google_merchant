module Spree
  ProductProperty.class_eval do
    scope :google_properties, ->{
      select(
        "#{table_name}.*, #{property_table_name}.name"
      ).joins(
        :property
      ).where(
        property_id: google_merchant_property_ids
      )
    }

    private

    def self.property_table_name
      Property.table_name
    end

    def self.google_merchant_property_ids
      GoogleMerchant::Manager.property_ids
    end
  end
end
