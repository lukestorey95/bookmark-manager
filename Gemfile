# frozen_string_literal: true

source "https://rubygems.org"

ruby '3.0.2'

gem 'puma'
gem 'sinatra'
gem 'webrick'
gem 'rerun'
gem 'sinatra-flash'

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'pg'
end

group :development, :test do
  gem 'rubocop', '1.20'
end