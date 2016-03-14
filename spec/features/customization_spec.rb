require 'spec_helper'

feature :customization do
  stub_authorization!

  background do
    reset_manager
    sign_in_as! create(:admin_user)
    Spree::GoogleMerchant::ProductManager::DEFAULT_MAPPING.each do |key, value|
      create(:property, name: key.to_s, presentation: value.tr('_', ' ').titleize)
    end
    create(:property, name: 'my_brand', presentation: 'My Brand')
    create(:option_type, name: 'variant_brand', presentation: 'Variant Brand')
    create(:product, available_on: 1.year.ago).tap do |product|
      Spree::Property.all.each do |property|
        create(:product_property, product: product, property: property, value: property.presentation)
      end
      create(:variant, product: product).tap do |variant|
        Spree::OptionType.all.each do |type|
          variant.option_values.create(
            option_type: type, name: "v_#{type.name}", presentation: "V: #{type.presentation}"
          )
        end
      end
    end
  end

  after do
    reset_manager
  end

  context 'with product_mapping' do
    it 'can remove a key' do
      expect {
        Spree::GoogleMerchant::Manager.product_mapping.delete(:google_merchant_brand)
      }.to change {
        visit '/google_merchant.rss'; page.body
      }.from(
        /<g:google_product_category>Google Product Category<\/g:google_product_category>\n<g:brand>Brand<\/g:brand>\n<g:department>Department<\/g:department>\n<g:color>Color<\/g:color>\n<g:gtin>Gtin<\/g:gtin>/
      ).to(
        /<g:google_product_category>Google Product Category<\/g:google_product_category>\n<g:department>Department<\/g:department>\n<g:color>Color<\/g:color>\n<g:gtin>Gtin<\/g:gtin>/
      )
    end

    it 'can replace a key' do
      expect {
        Spree::GoogleMerchant::Manager.product_mapping.delete(:google_merchant_brand)
        Spree::GoogleMerchant::Manager.product_mapping[:my_brand] = "replaced_brand"
      }.to change {
        visit '/google_merchant.rss'; page.body
      }.from(
        /<g:google_product_category>Google Product Category<\/g:google_product_category>\n<g:brand>Brand<\/g:brand>\n<g:department>Department<\/g:department>\n<g:color>Color<\/g:color>\n<g:gtin>Gtin<\/g:gtin>/
      ).to(
        /<g:google_product_category>Google Product Category<\/g:google_product_category>\n<g:department>Department<\/g:department>\n<g:color>Color<\/g:color>\n<g:gtin>Gtin<\/g:gtin>\n<g:replaced_brand>My Brand<\/g:replaced_brand>/
      )
    end

    it 'can default a key for all products' do
      expect {
        Spree::GoogleMerchant::Manager.product_mapping.delete(:google_merchant_brand)
        Spree::GoogleMerchant::Manager.product_fallbacks[:brand] = "Not In the Database"
      }.to change {
        visit '/google_merchant.rss'; page.body
      }.from(
        /<g:google_product_category>Google Product Category<\/g:google_product_category>\n<g:brand>Brand<\/g:brand>\n<g:department>Department<\/g:department>\n<g:color>Color<\/g:color>\n<g:gtin>Gtin<\/g:gtin>/
      ).to(
        /<g:brand>Not In the Database<\/g:brand>\n<g:google_product_category>Google Product Category<\/g:google_product_category>\n<g:department>Department<\/g:department>\n<g:color>Color<\/g:color>\n<g:gtin>Gtin<\/g:gtin>/
      )
    end

    context "showing variants" do
      before do
        Spree::GoogleMerchant::Manager.include_variants = true
      end

      it "can be overriden by variant values" do
        expect {
          Spree::GoogleMerchant::Manager.variant_mapping[:variant_brand] = "brand"
        }.to change {
          visit '/google_merchant.rss'; page.body
        }.from(
          /<g:google_product_category>Google Product Category<\/g:google_product_category>\n<g:brand>Brand<\/g:brand>/
        ).to(
          /<g:google_product_category>Google Product Category<\/g:google_product_category>\n<g:brand>V: Variant Brand<\/g:brand>/
        )
      end

      it "can add keys from the variant" do
        expect {
          Spree::GoogleMerchant::Manager.variant_mapping[:variant_brand] = "alt_brand"
        }.to change {
          visit '/google_merchant.rss'; page.body
        }.from(
          /<g:google_product_category>Google Product Category<\/g:google_product_category>\n<g:brand>Brand<\/g:brand>\n<g:department>Department<\/g:department>\n<g:color>Color<\/g:color>\n<g:gtin>Gtin<\/g:gtin>/
        ).to(
          /<g:google_product_category>Google Product Category<\/g:google_product_category>\n<g:brand>Brand<\/g:brand>\n<g:department>Department<\/g:department>\n<g:color>Color<\/g:color>\n<g:gtin>Gtin<\/g:gtin>\n<g:alt_brand>V: Variant Brand<\/g:alt_brand>/
        )
      end
    end
  end

  def reset_manager
    Spree::GoogleMerchant::Manager.product_mapping = Spree::GoogleMerchant::ProductManager::DEFAULT_MAPPING
    Spree::GoogleMerchant::Manager.product_fallbacks = {}
    Spree::GoogleMerchant::Manager.variant_mapping = {}
    Spree::GoogleMerchant::Manager.include_variants = false
    Spree::GoogleMerchant::Manager.advertising_image_proc = ->{order(:position)}
    Spree::GoogleMerchant::Manager.weight_unit = Spree::GoogleMerchant::ProductManager::VALID_WEIGHT_UNITS.first
  end
end
