require 'rspec'
require 'rack/test'
require 'sinatra'
require 'byebug'

set :environment, :test

def app
  PasswordService
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
