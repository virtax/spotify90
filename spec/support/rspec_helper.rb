require 'rspec/core'
require 'rspec/support'

RSpec::Support.require_rspec_core 'formatters/console_codes'
RSpec::Support.require_rspec_core 'formatters/documentation_formatter'

class RSpec::Core::Formatters::DocumentationFormatter
  def passed_output(example)
    if example.respond_to?(:striped_description)
      RSpec::Core::Formatters::ConsoleCodes.wrap("#{current_indentation + '  '}⋮ #{example.striped_description}", :success)
    else
      RSpec::Core::Formatters::ConsoleCodes.wrap("#{current_indentation}∟ #{example.description.strip}", :success)
    end
  end
end

module RspecHelpers
  def success(msg)
    RSpec.world.reporter.notify(
      :example_passed,
      OpenStruct.new(example: (OpenStruct.new(striped_description: msg)))
    )
  end
end

