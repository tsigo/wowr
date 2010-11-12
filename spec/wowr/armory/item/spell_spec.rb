require 'spec_helper'

module Wowr::Armory::Item
  describe Spell do
    subject { Spell.new(fake_element) }
    let(:expected_desc) { "Your healing spells have a chance to cause Blessing of Ancient Kings for 15 sec allowing your heals to shield the target absorbing damage equal to 15% of the amount healed." }

    its(:trigger)     { should eql(1) }
    its(:description) { should eql(expected_desc) }

    # Aliased methods
    its(:desc) { should eql(expected_desc) }
    its(:to_s) { should eql(expected_desc) }

    protected

    def fake_element
      xml = file_fixture('armory/item-tooltip/46017.xml')
      (Nokogiri::XML(xml)%'spellData'/'spell')[0]
    end
  end
end
