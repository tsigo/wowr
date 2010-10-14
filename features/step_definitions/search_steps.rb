When /^I search for an? (.+) named "([^"]+)"$/ do |type, name|
  # Hacky pluralization; got lucky with our types
  search_method = "search_#{(type + 's').downcase.gsub(/\s+/, '_')}"
  fixture_path  = type.downcase.gsub(/\s+/, '_')

  FakeWeb.register_uri(:get, /searchQuery=#{name}/, :body => file_fixture("#{fixture_path}_search_#{name.downcase}.xml"))
  @results = Wowr::API.new.send(search_method, name)
end

Then /^I should see the following YAML:$/ do |output|
  @results.to_yaml.to_s.should match(output)
end

Then /^I should see the following as the first result:$/ do |table|
  table.raw.each do |attr, val|
    @results[0].send(attr).to_s.should eql(val)
  end
end
