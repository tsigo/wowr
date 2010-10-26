require 'spec_helper'

module Wowr::Armory::Item
  describe SetBonus do
    subject { SetBonus.new(fake_element) }
    let(:expected_desc) { "Increases the damage done by your Devouring Plague by 15%." }

    its(:threshold)   { should eql(2) }
    its(:description) { should eql(expected_desc) }

    # Alias methods
    its(:desc) { should eql(expected_desc) }
    its(:to_s) { should eql(expected_desc) }

    protected

    def fake_element
      # http://www.wowarmory.com/item-tooltip.xml?i=46163
      xml = <<-XML
      <setData>
        <setBonus desc="Increases the damage done by your Devouring Plague by 15%." threshold="2"/>
        <setBonus desc="Your Mind Blast also grants you 240 haste rating for 4 sec." threshold="4"/>
      </setData>
      XML

      (Hpricot.XML(xml)%'setData'/'setBonus')[0]
    end
  end
end
