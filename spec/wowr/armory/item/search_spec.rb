require 'spec_helper'

module Wowr::Armory::Item
  describe Search do
    subject { Search.new(fake_element) }

    its(:url)         { should eql("i=45218") }
    its(:rarity)      { should eql(3) }
    its(:source)      { should eql('sourceType.vendor') }
    its(:item_level)  { should eql(200) }
    its(:relevance)   { should satisfy { |n| n > 0 && n <= 100 } }

    # Aliased methods
    its(:level) { should eql(200) }

    protected

    def fake_element
      xml = file_fixture('armory/search/items_cake.xml')
      (Hpricot.XML(xml)%'items'/'item')[0]
    end
  end
end
