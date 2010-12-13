require 'rspec/expectations'

module SuperclassMatcher
  extend RSpec::Matchers::DSL

  matcher :be_percentage do
    match do |subject|
      subject.kind_of?(Float) && subject >= 0.00 && subject <= 100.00
    end

    failure_message_for_should do |actual|
      "expected #{actual} to be a Float between 0.00 and 100.00"
    end
  end
end
