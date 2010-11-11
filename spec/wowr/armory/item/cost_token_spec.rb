require 'spec_helper'

module Wowr::Armory::Item
  describe CostToken do
    subject { CostToken.new(fake_element) }

    its(:count) { should eql(20) }

    its(:class) { should superclass(Base) }

    protected

    def fake_element
      xml = file_fixture('armory/item-info/27644.xml')
      (Hpricot.XML(xml)%'cost'/'token')[0]
    end
  end
end
