require 'spec_helper'

describe Spree::ProductsController do
  stub_authorization!

  describe :google_merchant do
    let!(:product) { create(:product, available_on: 1.year.ago) }
    let(:user) { create(:user) }

    before do
      controller.stub :spree_current_user => user
    end

    it 'sets @products instance variable' do
      spree_get :google_merchant, format: :rss

      assigns(:products).should_not be_nil
      assigns(:products).first.should eql(product)
    end

    it 'renders the proper RSS template' do
      spree_get :google_merchant, format: :rss

      response.should be_success
      response.content_type.should eq("application/rss+xml")
      response.should render_template("spree/products/google_merchant")
    end
  end
end
