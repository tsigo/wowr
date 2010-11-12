require 'spec_helper'

module Wowr::Armory::Item
  describe SetData do
    subject { SetData.new(fake_element) }

    its(:name) { should eql("Sanctification Garb") }
    its(:items) { should be_an(Array) }
    its(:set_bonuses) { should be_an(Array) }

    # Aliased methods
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
      xml = file_fixture('armory/item-tooltip/46163.xml')
      (Nokogiri::XML(xml)%'setData')
    end
  end
end
