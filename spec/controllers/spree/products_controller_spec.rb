require 'spec_helper'

describe Spree::ProductsController do
  describe :google_merchant do
    it 'sets @products instance variable' do
      get :google_merchant
      assigns(:products).should_not be_nil
    end
  end
end
