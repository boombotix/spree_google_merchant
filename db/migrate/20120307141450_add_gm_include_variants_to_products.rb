class AddGmIncludeVariantsToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :google_merchant_include_variants, :boolean, :default => false
    add_column :spree_products, :google_merchant_brand, :string
    add_column :spree_products, :google_merchant_product_category, :string
    add_column :spree_products, :google_merchant_product_type, :string
  end
end