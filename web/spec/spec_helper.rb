require 'rack/test'
require 'rspec'
require './spec/support/json_helper'
require './spec/support/fixture_helpers'
require 'simplecov'
require 'ruby-prof'

SimpleCov.start

ENV['RACK_ENV'] = 'test'
require './app.rb'

def app
  App.new
end

module RSpecMixin
  include Rack::Test::Methods
end

RSpec.configure do | config |
  config.include RSpecMixin
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  # logging
  ActiveRecord::Base.logger = Logger.new(nil)

  # FactoryGirl configs and database cleaner
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    FactoryGirl.find_definitions
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    FactoryGirl.reload
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Rspec output config
  config.formatter =  :documentation
end

def start_profiling
  RubyProf.start
end

def end_profiling
  printer = RubyProf::MultiPrinter.new(RubyProf.stop)
  printer.print(:path => ".", :profile => "profile")
end
