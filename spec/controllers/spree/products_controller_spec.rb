require 'spec_helper'

describe Spree::ProductsController do
  describe :google_merchant do
    let!(:product) { create(:product, available_on: 1.year.ago) }

    it 'sets @products instance variable' do
      spree_get :google_merchant, format: :rss
      assigns(:products).should_not be_nil
      assigns(:products).first.should eql(product)
    end
  end
end
