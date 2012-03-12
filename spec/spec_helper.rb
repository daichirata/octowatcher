$:.unshift(File.dirname(__FILE__))
$:.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

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
