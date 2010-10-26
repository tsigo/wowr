require 'spec_helper'

module Wowr::Armory::Item
  describe CostToken do
    subject { CostToken.new(fake_element) }

    its(:count) { should eql(1) }

    # Inherited from Base
    its(:id) { should eql(52030) }
    its(:name) { should be_nil }
    its(:icon_base) { should eql("ability_paladin_judgementsofthejust") }

    protected

    def fake_element
      # http://www.wowarmory.com/item-info.xml?i=51255
      xml = <<-XML
      <token count="1" icon="ability_paladin_judgementsofthejust" id="52030"/>
      XML

      (Hpricot.XML(xml)%'token')
    end
  end
end
