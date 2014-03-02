require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rubygems/package_task'
require 'rspec/core/rake_task'
require 'spree/testing_support/common_rake'

RSpec::Core::RakeTask.new

task :default => :spec

spec = eval(File.read('spree_google_merchant.gemspec'))

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc 'Generates a dummy app for testing'
task :test_app do
  ENV['LIB_NAME'] = 'spree_google_merchant'
  Rake::Task['common:test_app'].invoke("Spree::LegacyUser")
end














# require 'rubygems'
# require 'rubygems/package_task'
# require 'rake'
# require 'rake/testtask'

# gemfile = File.expand_path('../spec/test_app/Gemfile', __FILE__)
# if File.exists?(gemfile) && (%w(spec).include?(ARGV.first.to_s) || ARGV.size == 0)
#   require 'bundler'
#   ENV['BUNDLE_GEMFILE'] = gemfile
#   Bundler.setup

#   require 'rspec'
#   require 'rspec/core/rake_task'
#   RSpec::Core::RakeTask.new
# end

# desc "Default Task"
# task :default => [:spec]

# spec = eval(File.read('spree_google_merchant.gemspec'))

# # Rake::GemPackageTask.new(spec) do |p|
# #   p.gem_spec = spec
# # end

# desc "Release to gemcutter"
# task :release => :package do
#   require 'rake/gemcutter'
#   Rake::Gemcutter::Tasks.new(spec).define
#   Rake::Task['gem:push'].invoke
# end

# desc "Default Task"
# task :default => [ :spec ]

# desc "Regenerates a rails 4 app for testing"
# task :test_app do
#   require 'core/lib/generators/spree/test_app_generator'
#   class SpreeGoogleMerchantTestAppGenerator < Spree::Generators::TestAppGenerator

#     def install_gems
#       inside "test_app" do
#         run 'rake spree_core:install'
#         run 'rake spree_google_merchant:install'
#       end
#     end

#     def migrate_db
#       run_migrations
#     end

#     protected
#     def full_path_for_local_gems
#       <<-gems
# gem 'spree_core', :path => \'#{File.join(File.dirname(__FILE__), "../spree/", "core")}\'
# gem 'spree_google_merchant', :path => \'#{File.dirname(__FILE__)}\'
#       gems
#     end

#   end
#   SpreeGoogleMerchantTestAppGenerator.start
# end

# namespace :test_app do
#   desc 'Rebuild test and cucumber databases'
#   task :rebuild_dbs do
#     system("cd spec/test_app && rake db:drop db:migrate RAILS_ENV=test && rake db:drop db:migrate RAILS_ENV=test")
#   end
# end
