Spree::Core::Engine.routes.prepend do
  match "google_merchant", :to => 'products#google_merchant', :via => [:get, :post]

  namespace :admin do
    resource :google_merchants
  end
end
