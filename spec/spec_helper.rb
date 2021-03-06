# frozen_string_literal: true
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'rspec'
require 'rspec/mocks'
require 'parslet/rig/rspec'
require 'parser_helper'

require 'doc_formatter'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rb_tags'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.order = :random
end
