require 'spec_helper'

describe Spree::Admin::GoogleMerchantsController do
  stub_authorization!

  describe :update do
    let(:user) { create(:user) }

    before do
      controller.stub :spree_current_user => user
    end

    it 'sets Spree::GoogleMerchant::Config to a preferences hash' do
      spree_put :update, preferences: {
        google_merchant_title: 'title',
        google_merchant_description: 'description',
        production_domain: 'domain'
      }, format: :html

      response.should redirect_to spree.admin_google_merchants_path

      Spree::GoogleMerchant::Config.google_merchant_title.should eql('title')
      Spree::GoogleMerchant::Config.google_merchant_description.should eql('description')
      Spree::GoogleMerchant::Config.production_domain.should eql('domain')
    end
  end
end
