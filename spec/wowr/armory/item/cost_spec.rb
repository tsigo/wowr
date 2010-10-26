require 'spec_helper'

module Wowr::Armory::Item
  describe Cost, "with tokens" do
    subject { Cost.new(fake_element) }

    its(:buy_price)   { should be_nil }
    its(:sell_price)  { should be_nil }
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
      # http://www.wowarmory.com/item-info.xml?i=51255
      xml = <<-XML
      <cost>
        <token count="1" icon="ability_paladin_judgementsofthejust" id="52030"/>
        <token count="1" icon="inv_helmet_156" id="51184"/>
      </cost>
      XML

      (Hpricot.XML(xml)%'cost')
    end
  end

  describe Cost, "without tokens" do
    subject { Cost.new(fake_element) }

    its(:buy_price)   { should be_a(Wowr::Classes::Money) }
    its(:sell_price)  { should be_a(Wowr::Classes::Money) }
    its(:tokens)      { should be_nil }
    its(:honor_price) { should be_nil }
    its(:arena_price) { should be_nil }

    protected

    def fake_element
      # http://www.wowarmory.com/item-info.xml?i=16453
      xml = <<-XML
      <cost buyPrice="201241" sellPrice="40248"/>
      XML

      (Hpricot.XML(xml)%'cost')
    end
  end
end
