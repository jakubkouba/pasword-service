# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'sinatra'

group :development, :test do
  gem 'guard-rspec'
  gem 'pry-byebug'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'rubocop'
end