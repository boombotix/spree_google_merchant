class AddGoogleMerchantFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :spree_variants, :google_merchant_gtin, :string
    add_column :spree_variants, :google_merchant_brand, :string
    add_column :spree_variants, :google_merchant_product_category, :string
    add_column :spree_variants, :google_merchant_product_type, :string
  end
end