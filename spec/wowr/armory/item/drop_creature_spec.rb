require 'spec_helper'

module Wowr::Armory::Item
  describe DropCreature do
    subject { DropCreature.new(fake_element) }

    its(:name)            { should eql("Ragnaros") }
    its(:id)              { should eql(11502) }
    its(:min_level)       { should eql(63) }
    its(:max_level)       { should eql(63) }
    its(:drop_rate)       { should eql(2) }
    its(:classification)  { should eql(3) }
    its(:area)            { should eql("Molten Core") }
    its(:type)            { should eql("Elemental") }

    # FIXME: No attr_reader defined for these attributes; intentional? (tsigo)
    # its(:title)           { should be_nil }
    # its(:url)             { should_not be_nil }
    # its(:area_url)        { should_not be_nil }

    protected

    def fake_element
      xml = file_fixture('armory/item-info/17204.xml')
      (Nokogiri::XML(xml)%'dropCreatures'/'creature')[0]
    end
  end
end
