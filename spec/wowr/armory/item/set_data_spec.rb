require 'spec_helper'

module Wowr::Armory::Item
  describe SetData do
    subject { SetData.new(fake_element) }

    its(:name) { should eql("Sanctification Garb") }
    its(:items) { should be_an(Array) }
    its(:set_bonuses) { should be_an(Array) }

    # Alias methods
    its(:to_s) { should eql("Sanctification Garb") }

    it "should parse items in the set" do
      subject.items.length.should eql(5)
    end

    describe "set bonuses" do
      it "should collect all bonuses" do
        subject.set_bonuses.length.should eql(2)
      end

      it "should be an array of SetBonus instances" do
        subject.set_bonuses[0].should be_kind_of(SetBonus)
      end
    end

    protected

    def fake_element
      # http://www.wowarmory.com/item-tooltip.xml?i=46163
      xml = <<-XML
      <setData>
        <name>Sanctification Garb</name>
        <item name="Circlet of Sanctification"/>
        <item name="Handwraps of Sanctification"/>
        <item name="Mantle of Sanctification"/>
        <item name="Pants of Sanctification"/>
        <item name="Raiments of Sanctification"/>
        <setBonus desc="Increases the damage done by your Devouring Plague by 15%." threshold="2"/>
        <setBonus desc="Your Mind Blast also grants you 240 haste rating for 4 sec." threshold="4"/>
      </setData>
      XML

      (Hpricot.XML(xml)%'setData')
    end
  end
end
