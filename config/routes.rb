Spree::Core::Engine.routes.append do
  match '/admin/google_merchant', to: 'products#google_merchant', via: [:get, :post], as: 'admin_google_merchants'
end
