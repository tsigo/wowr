require 'spec_helper'

module Wowr::Armory::Item
  describe Source do
    subject { Source.new(fake_element) }

    its(:value)          { should eql("sourceType.creatureDrop") }
    its(:area_id)        { should eql(2159) }
    its(:area_name)      { should eql("Onyxia's Lair") }
    its(:creature_id)    { should eql(10184) }
    its(:creature_name)  { should eql("Onyxia") }
    its(:difficulty)     { should eql("n") }
    its(:drop_rate)      { should eql(6) }
    # its(:required_level) { should be_nil } # FIXME: No attr_reader defined; intentional? (tsigo)

    protected

    def fake_element
      xml = file_fixture('armory/item-tooltip/49295.xml')
      (Nokogiri::XML(xml)%'itemSource')
    end
  end
end
