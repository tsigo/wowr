require 'spec_helper'

module Wowr::Armory::Item
  describe Created do
    subject { Created.new(fake_element) }

    its(:type)    { should eql('Two-Handed Maces') }
    its(:level)   { should eql(80) }
    its(:quality) { should eql(5) }

    its(:class) { should superclass(Base) }

    protected

    def fake_element
      xml = file_fixture('armory/item-info/17204.xml')
      (Nokogiri::XML(xml)%'reagentFor'/'spell'/'item')[0]
    end
  end
end
