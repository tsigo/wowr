When /^I search for a character named "([^"]+)"$/ do |name|
  FakeWeb.register_uri(:get, /searchQuery=#{name}/, :body => file_fixture("character_search_#{name.downcase}.xml"))
  @results = Wowr::API.new.search_characters(name)
end

Then /^I should receive the following YAML:$/ do |output|
  @results.to_yaml.to_s.should match(output)
end

Then /^I should see the following result:$/ do |table|
  table.raw.each do |attr, val|
    @results[0].send(attr).to_s.should eql(val)
  end
end
