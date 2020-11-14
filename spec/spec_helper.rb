require 'rspec'
require 'rack/test'
require 'sinatra'
require 'byebug'

set :environment, :test
$LOAD_PATH.push(File.expand_path('../app/lib', File.dirname(__FILE__ )))

def app
  PasswordService
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
