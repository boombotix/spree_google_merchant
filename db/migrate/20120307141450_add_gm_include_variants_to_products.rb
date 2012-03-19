class AddGmIncludeVariantsToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :google_merchant_include_variants, :boolean, :default => false
  end
end