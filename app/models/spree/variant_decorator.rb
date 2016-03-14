module Spree
  Variant.class_eval do
    has_one(
      :advertising_image,
      Spree::GoogleMerchant::Manager.advertising_image_proc,
      as: :viewable,
      class_name: "Spree::Image"
    )
    has_one :master, ->{ where(is_master: true) }, primary_key: :product_id, foreign_key: :product_id, class_name: "Spree::Variant"
    has_one :first_non_master, ->{ where(is_master: false).order(:id) }, primary_key: :product_id, foreign_key: :product_id, class_name: "Spree::Variant"

    def advertising_image_url
      advertising_image.try(:attachment).try(:url, :product)
    end
  end
end
