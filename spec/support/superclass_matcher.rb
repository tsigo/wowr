require 'rspec/expectations'

module SuperclassMatcher
  extend RSpec::Matchers::DSL

  matcher :superclass do |expected|
    match do |subject|
      subject.superclass == expected
    end

    failure_message_for_should do |actual|
      "expected that superclass would be #{expected}, but instead got #{actual}"
    end
  end
end
