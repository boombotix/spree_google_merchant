require 'spec_helper'

describe Spree::Admin::GoogleMerchantsController do
  describe :update do
    it 'sets @products instance variable' do
      patch :update
      assigns(:products).should_not be_nil
    end
  end
end
