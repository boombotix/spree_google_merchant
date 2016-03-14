require 'spec_helper'

feature :products do
  stub_authorization!

  background do
    sign_in_as! create(:admin_user)
    create(:product, available_on: 1.year.ago)
  end

  context 'show rss', js: true do
    it 'shows the RSS feed' do
      visit '/google_merchant.rss'
      xml = Nokogiri::XML(page.body)

      # ensure 1 product
      expect(xml.css('item').size).to eql(1)

      # ensure RSS formatting tag
      expect(xml.css('rss').size).to eql(1)

      # ensure title, description, domain match our config
      expect(xml.css("rss").first.css('title').first.children.first.text).to eql(Spree::GoogleMerchant::Config.google_merchant_title)
      expect(xml.css("rss").first.css('description').first.children.first.text).to eql(Spree::GoogleMerchant::Config.google_merchant_description)
      expect(xml.css("rss").first.css('link').first.children.first.text).to eql(Spree::GoogleMerchant::Config.production_domain)
    end
  end

  context 'show xml', js: true do
    it 'shows the same content for the XML feed' do
      visit '/google_merchant.rss'
      rss = page.body

      visit '/google_merchant.xml'
      xml = page.body

      expect(xml).to eq(rss)
    end
  end
end
