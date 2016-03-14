require 'spec_helper'

describe Spree::ProductsController do
  stub_authorization!

  describe :google_merchant do
    let!(:product) { create(:product, available_on: 1.year.ago) }
    let(:user) { create(:user) }

    before do
      controller.stub :spree_current_user => user
    end

    it 'sets the right instance variable' do
      spree_get :google_merchant, format: :rss

      assigns(:items).should_not be_nil
      assigns(:items).first.should eql(product)
    end

    context 'with full_variants set' do
      before do
        Spree::GoogleMerchant::Manager.include_variants = true
      end

      it 'sets the right instance variable with only master variants' do
        spree_get :google_merchant, format: :rss

        assigns(:items).first.should eql(product.master)
      end

      it 'sets the right instance variable with multiple variants' do
        variant = create(:variant, product: product)

        spree_get :google_merchant, format: :rss

        assigns(:items).first.should eql(variant)
      end
    end

    it 'renders the proper RSS template' do
      spree_get :google_merchant, format: :rss

      response.should be_success
      response.content_type.should eq("application/rss+xml")
      response.should render_template("spree/products/google_merchant")
    end
  end
end
