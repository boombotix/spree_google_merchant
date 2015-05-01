require 'spec_helper'

describe Spree::Admin::GoogleMerchantsController do
  stub_authorization!

  describe '#update' do
    let(:user) { create(:user) }

    before do
      allow(controller).to receive(:spree_current_user) { user }
    end

    it 'sets Spree::GoogleMerchant::Config to a preferences hash' do
      spree_put :update, preferences: {
        google_merchant_title: 'title',
        google_merchant_description: 'description',
        production_domain: 'domain'
      }, format: :html

      expect(response).to redirect_to spree.admin_google_merchants_path

      expect(Spree::GoogleMerchant::Config.google_merchant_title).to eql('title')
      expect(Spree::GoogleMerchant::Config.google_merchant_description).to eql('description')
      expect(Spree::GoogleMerchant::Config.production_domain).to eql('domain')
    end
  end
end
