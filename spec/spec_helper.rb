ENV['BUNDLE_GEMFILE'] ||= File.expand_path(File.dirname(__FILE__) + '/../Gemfile')
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
Bundler.require :default if defined?(Bundler)

$:.unshift(File.dirname(__FILE__))
$:.unshift(File.join(File.dirname(__FILE__), '..'))

require 'app'
require 'rspec'
require 'rack/test'

module MockApp
  def app
    @app ||= OctoWatcher::App
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include MockApp
end
