class AddGoogleMerchantFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :spree_variants, :google_merchant_gtin, :string
  end
end