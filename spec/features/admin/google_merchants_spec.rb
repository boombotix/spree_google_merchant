require 'spec_helper'

feature :google_merchants do
  stub_authorization!

  background do
    sign_in_as! create(:admin_user)

    visit spree.admin_path
    click_link 'Configuration'
    click_link 'Google Merchant'
  end

  context :show, js: true do
    it 'shows the link to the RSS feed' do
      within '.page-actions' do
        page.should have_selector("a[href='/google_merchant.rss']")
      end
    end

    it 'redirects to the RSS feed' do
      click_link 'View Google Merchant Feed'
      current_path.should eql('/google_merchant.rss')
    end

    it 'shows the three Spree::GoogleMerchant::Config values in table' do
      page.should have_selector('table td', text: Spree::GoogleMerchant::Config.google_merchant_title)
      page.should have_selector('table td', text: Spree::GoogleMerchant::Config.google_merchant_description)
      page.should have_selector('table td', text: Spree::GoogleMerchant::Config.production_domain)
    end
  end

  context :edit, js: true do
    background do
      click_on 'Edit'
    end

    it 'updates the three Spree::GoogleMerchant::Config values' do
      fill_in 'preferences_google_merchant_title',       with: 'Some title'
      fill_in 'preferences_google_merchant_description', with: 'Some description'
      fill_in 'preferences_production_domain',           with: 'Some production domain'
      click_on 'Update'

      current_path.should eql(spree.admin_google_merchants_path)
      page.should have_selector('table td', text: 'Some title')
      page.should have_selector('table td', text: 'Some description')
      page.should have_selector('table td', text: 'Some production domain')
    end
  end
end
