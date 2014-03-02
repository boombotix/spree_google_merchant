Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_google_merchant'
  s.version     = '1.1.0'
  s.summary     = 'Google Merchant RSS feed for Spree 2.2'
  s.description = 'Google Merchant RSS feed for Spree 2.2'
  s.required_ruby_version = '>= 2.0.0'

  s.author            = 'Tim Neems, sebastyuiop, Ben Radler'
  s.email             = 'ben@boombotix.com'
  # s.homepage          = 'http://www.rubyonrails.org'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree_core', '>= 2.2.0')
end
