require 'spec_helper'

feature :products do
  stub_authorization!

  background do
    sign_in_as! create(:admin_user)
    create(:product, available_on: 1.year.ago)
    visit '/google_merchant.rss'
  end

  context :show, js: true do
    it 'shows the RSS feed' do
      xml = Nokogiri::XML(page.body)

      # ensure 1 product
      xml.css('item').size.should eql(1)

      # ensure RSS formatting tag
      xml.css('rss').size.should eql(1)

      # ensure title, description, domain match our config
      xml.css("rss").first.css('title').first.children.first.text.should eql(Spree::GoogleMerchant::Config.google_merchant_title)
      xml.css("rss").first.css('description').first.children.first.text.should eql(Spree::GoogleMerchant::Config.google_merchant_description)
      xml.css("rss").first.css('link').first.children.first.text.should eql(Spree::GoogleMerchant::Config.production_domain)
    end
  end
end
