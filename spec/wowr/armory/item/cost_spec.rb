require 'spec_helper'

module Wowr::Armory::Item
  describe Cost, "with tokens" do
    subject { Cost.new(fake_element) }

    its(:buy_price)   { subject.to_i.should eql(137_714) }
    its(:sell_price)  { subject.to_i.should eql(27_542) }
    its(:tokens)      { should be_an(Array) }
    its(:honor_price) { should be_nil }
    its(:arena_price) { should be_nil }

    describe "tokens" do
      it "should collect all tokens" do
        subject.tokens.length.should eql(2)
      end

      it "should be an array of CostToken instances" do
        subject.tokens[0].should be_a(CostToken)
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/item-info/27644.xml')
      (Hpricot.XML(xml)%'cost')
    end
  end

  describe Cost, "without tokens" do
    subject { Cost.new(fake_element) }

    its(:buy_price)   { should be_nil }
    its(:sell_price)  { subject.to_i.should eql(225_096) }
    its(:tokens)      { should eql([]) }
    its(:honor_price) { should be_nil }
    its(:arena_price) { should be_nil }

    protected

    def fake_element
      xml = file_fixture('armory/item-info/40395.xml')
      (Hpricot.XML(xml)%'cost')
    end
  end
end
