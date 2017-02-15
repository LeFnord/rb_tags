# frozen_string_literal: true
require 'rspec/core/formatters/console_codes'

class Doc
  RSpec::Core::Formatters.register self, :example_passed, :example_pending, :example_failed, :close

  def initialize(output)
    @output = output
  end

  def example_passed(notification)
    @output << RSpec::Core::Formatters::ConsoleCodes.wrap(". \
      #{notification.example.metadata[:example_group][:description]}\n", :success)
  end

  def example_failed(notification)
    @output << RSpec::Core::Formatters::ConsoleCodes.wrap("F \
      #{notification.example.metadata[:example_group][:description]} \
      #{notification.example.exception}\n", :failure)
  end

  def example_pending(_notification)
    @output << RSpec::Core::Formatters::ConsoleCodes.wrap('*', :pending)
  end

  def close(_notification)
    @output << "\n"
  end
end
