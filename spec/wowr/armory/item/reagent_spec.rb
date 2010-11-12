require 'spec_helper'

module Wowr::Armory::Item
  describe Reagent do
    subject { Reagent.new(fake_element) }

    its(:count) { should eql(40) }

    its(:class) { should superclass(Base) }

    protected

    def fake_element
      xml = file_fixture('armory/item-info/47579.xml')
      (Nokogiri::XML(xml)%'spell'/'reagent')[0]
    end
  end
end
