require 'spec_helper'
require './web/server.rb'
require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end


