require 'spec_helper'

module Wowr::Armory::Item
  describe Vendor do
    subject { Vendor.new(fake_element) }

    its(:id)             { should eql(28995) }
    its(:name)           { should eql("Paldesse") }
    its(:title)          { should eql("Cloth Armor Merchant") }
    its(:type)           { should eql("Humanoid") }
    its(:area)           { should eql("Crystalsong Forest") }
    its(:classification) { should eql(0) }
    its(:max_level)      { should eql(75) }
    its(:min_level)      { should eql(75) }

    protected

    def fake_element
      xml = <<-XML
      <vendors>
        <creature area="Crystalsong Forest" classification="0" heroic="1" id="28995" maxLevel="75" minLevel="75" name="Paldesse" title="Cloth Armor Merchant" type="Humanoid"/>
      </vendors>
      XML

      (Hpricot.XML(xml)%'vendors'/'creature')[0]
    end
  end
end
