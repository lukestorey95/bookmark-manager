ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'
require 'web_helpers'

require 'capybara'
require 'capybara/rspec'
require 'rspec'

Capybara.app = BookmarkManager

RSpec.configure do |config|
  config.before(:each) do
    empty_test_bookmarks
  end
end
